// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./RntERC20.sol";
import "./EsRntERC20.sol";

// 编写一个质押挖矿合约，实现如下功能：

// 用户随时可以质押项目方代币 RNT(自定义的ERC20) ，开始赚取项目方Token(esRNT)；
// 可随时解押提取已质押的 RNT；
// 可随时领取esRNT奖励，每质押1个RNT每天可奖励 1 esRNT;
// esRNT 是锁仓性的 RNT， 1 esRNT 在 30 天后可兑换 1 RNT，随时间线性释放，支持提前将 esRNT 兑换成 RNT，但锁定部分将被 burn 燃烧掉。
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeMine {
    mapping(address => uint256) tokenMap;

    //锁仓周期
    uint256 public _lockDuration = 30 days;

    //最近质押时间
    // mapping(address => uint256) public _lastStakeTime;

    //计算线性释放： 质押时间和代币数量
    mapping(address => mapping(uint256 => uint256)) public _stakeInfo;
    //用户质押的时间记录
    mapping(address => uint256[]) public _stakeInfoTime;

    //最近认领时间
    mapping(address => uint256) public _lastClaimTime;
    //用户质押数量
    mapping(address => uint256) private _stakebalances;
    //质押的时间
    mapping(address => uint256) public _stakeTime;

    //收益率 1 表示100%
    uint256 public rewardRate = 1;
    //代币方
    RntERC20 internal _rntERC20;
    //代币方：收益
    EsRntERC20 internal _esrntERC20;

    //用户质押信息
    // struct stakeInfo {
    //     address sender;
    //     uint256 amount;
    //     uint256 time;
    // }

    constructor(address rntERC20, address esrntERC20) {
        _rntERC20 = RntERC20(rntERC20);
        _esrntERC20 = EsRntERC20(esrntERC20);
    }
    //      StakeInfo memory newStakeInfo = StakeInfo(_sender, _amount, _time);
    //     stakeInfoArray.push(newStakeInfo);

    //质押
    function stake(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        //获取rntCnt数量
        uint256 rntCnt = _rntERC20.balanceOf(msg.sender);
        require(rntCnt > 0, "RNTCoin must be > 0!");
        require(rntCnt >= amount, "not enough RNT!");

        //记录每个时间点用户获取的金额
        _stakeInfo[msg.sender][block.timestamp] = amount;
        //累计金额
        _stakebalances[msg.sender] += amount;
        //添加用户时间记录
        uint256[] memory stakePoints = _stakeInfoTime[msg.sender];
        stakePoints[stakePoints.length] = block.timestamp;
        _stakeInfoTime[msg.sender] = stakePoints;

        _rntERC20.transferFrom(msg.sender, address(this), amount);
    }

    //可随时解押提取已质押的 RNT todo 正常认领代币 线性释放代币 未到期获取代币 剩下继续质押代币
    function cancelStake(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        require(_stakebalances[msg.sender] >= amount, "not enough RNT!");

        //计算收益
        uint256 reward = calculateReward(_stakebalances[msg.sender]);
        if (reward > 0) {
            _lastClaimTime[msg.sender] = block.timestamp;
            require(_esrntERC20.transfer(msg.sender, reward), "Reward transfer failed");
        }
        //代币归还
        _rntERC20.transfer(msg.sender, reward);
    }

    //到期用户获取代币收益 释放质押
    function claimReward() external {
        uint256 amount = _stakebalances[msg.sender];
        uint256 reward = calculateReward(amount);
        require(reward > 0, "No reward to claim");

        //代币归还
        _rntERC20.transfer(msg.sender, amount);

        //收益转移
        _esrntERC20.transfer(msg.sender, reward);
        _lastClaimTime[msg.sender] = block.timestamp;
    }

    //将 esRNT 兑换成 RNT，但锁定部分将被 burn 燃烧掉
    function convertRnt(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        require(_stakebalances[msg.sender] >= amount, "not enough stakebalance!");

        //计算收益
        uint256 reward = calculateReward(amount);
        require(amount > reward, "No reward to claim");

        //代币兑换RNT
        _rntERC20.transfer(msg.sender, amount);

        //esRNT 代币燃烧
        _esrntERC20.transfer(address(0), amount);
    }

    //计算收益: 收益 领取收益的RNT
    function calculateReward(uint256 amount) public view returns (uint256) {
        uint256 reward;
        uint256 addStake;
        uint256 arrIndex;
        uint256[] memory stakePoints = _stakeInfoTime[msg.sender];
        for (uint256 i = 0; i < stakePoints.length; i++) {
            uint256 sinceLastClaim = block.timestamp - stakePoints[i];
            //获取那个时间点质押的代币
            uint256 stCnt = _stakeInfo[msg.sender][stakePoints[i]];
            addStake += stCnt;
            if (amount > addStake) {
                reward = getStakeReward(sinceLastClaim, stCnt, 30 days);
            } else {
                reward = getStakeReward(sinceLastClaim, amount + stCnt - addStake, 30 days);
                break;
            }
            arrIndex++;
        }
        //移除已经认领的时间
        if (stakePoints.length == 1) {
            return reward;
        }

        for (uint256 i = 0; i < stakePoints.length; i++) {
            if (arrIndex == stakePoints.length) {
                break;
            }
            // 将符合条件的元素移到数组末尾
            stakePoints[i] = stakePoints[arrIndex];
            arrIndex++;
        }

        return reward;
    }

    function getStakeReward(uint256 claimTime, uint256 amount, uint256 interval_time) internal view returns (uint256) {
        if (claimTime >= interval_time) {
            //每天认领1个coin
            return (claimTime * rewardRate * amount) / (1 days);
        } else {
            //提前解锁，只能领取所有收益的1%
            return (claimTime * rewardRate * amount) / (1 days) / 100;
        }
    }
}
