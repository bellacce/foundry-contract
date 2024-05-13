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
    //用户质押数量
    mapping(address => uint256) private _stakebalances;
    //最近质押时间
    mapping(address => uint256) public _lastStakeTime;
    //最近认领时间
    mapping(address => uint256) public _lastClaimTime;
    //收益率 1 表示100%
    uint256 public rewardRate = 1;

    //代币方
    RntERC20 internal _rntERC20;
    //代币方：收益
    EsRntERC20 internal _esrntERC20;

    constructor(address rntERC20, address esrntERC20) {
        _rntERC20 = RntERC20(rntERC20);
        _esrntERC20 = EsRntERC20(esrntERC20);
    }

    //质押
    function stake(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        //获取rntCnt数量
        uint256 rntCnt = _rntERC20.balanceOf(msg.sender);
        require(rntCnt > 0, "RNTCoin must be > 0!");
        require(rntCnt >= amount, "not enough RNT!");

        _lastStakeTime[msg.sender] = block.timestamp;
        _stakebalances[msg.sender] += amount;

        _rntERC20.transferFrom(msg.sender, address(this), amount);
    }

    //可随时解押提取已质押的 RNT
    function cancelStake(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        require(_stakebalances[msg.sender] >= amount, "not enough RNT!");

        //计算收益
        uint256 reward = calculateReward(msg.sender);
        if (reward > 0) {
            _lastClaimTime[msg.sender] = block.timestamp;
            require(_esrntERC20.transfer(msg.sender, reward), "Reward transfer failed");
        }
        //代币归还
        _rntERC20.transfer(msg.sender, reward);
    }

    //到期用户获取代币收益 释放质押
    function claimReward() external {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward to claim");

        //代币归还
        _rntERC20.transfer(msg.sender, _stakebalances[msg.sender]);

        //收益转移
        _esrntERC20.transfer(msg.sender, reward);
        _lastClaimTime[msg.sender] = block.timestamp;
    }

    //将 esRNT 兑换成 RNT，但锁定部分将被 burn 燃烧掉
    function convertRnt(uint256 amount) external {
        require(amount > 0, "amount must be > 0!");
        require(_stakebalances[msg.sender] >= amount, "not enough stakebalance!");

        //计算收益
        uint256 reward = calculateReward(msg.sender);
        require(amount > reward, "No reward to claim");

        //代币兑换RNT
        _rntERC20.transfer(msg.sender, amount);

        //esRNT 代币燃烧
        _esrntERC20.transfer(address(0), amount);
    }

    //计算收益
    function calculateReward(address account) public view returns (uint256) {
        uint256 timeSinceLastClaim = block.timestamp - _lastClaimTime[account];
        uint256 reward = 0;
        //判断锁仓周期是不是30天
        if (timeSinceLastClaim >= 30 days) {
            //每天认领1个coin
            reward = (timeSinceLastClaim * rewardRate * _stakebalances[account]) / (1 days);
        } else {
            //提前解锁，只能领取所有收益的1%
            reward = (timeSinceLastClaim * rewardRate * _stakebalances[account]) / (1 days) / 100;
        }
        return reward;
    }
}
