// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./IStaking.sol";
import "./KKToken.sol";
import {Test, console} from "forge-std/Test.sol";

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

//编写 StakingPool 合约，实现 Stake 和 Unstake 方法，
// 允许任何人质押ETH来赚钱 KK Token。其中 KK Token 是每一个区块产出 10 个，产出的 KK Token 需要根据质押时长和质押数量来公平分配。
contract StakingPool is IStaking {
    using Address for address payable;

    KKToken public _kkToken;

    uint256 public _addPerTokenSpeed; //累计每次的平均奖励
    uint256 public _lastBlockNumber = block.number; //最新的区块高度
    uint256 public constant precision = 10 * 1e15; //精度

    uint256 public _totalStaked;

    mapping(address => StakeInfo) _addrStake;

    struct StakeInfo {
        uint256 award; //待领取奖励
        uint256 ethCnt; //存入的数量
        uint256 perTokenSpeed; //存储这次的平均奖励
    }

    constructor(address kkToken) {
        _kkToken = KKToken(kkToken);
    }

    receive() external payable {}

    /**
     * @dev 质押 ETH 到合约
     */
    function stake() external payable {
        require(msg.value > 0, "not enough coin!");
        StakeInfo storage stakeInfo = _addrStake[msg.sender];
        stakeInfo.ethCnt += msg.value;
        _totalStaked += msg.value;

        //计算用户的奖励
        calculatedGobalPerAward();
        calculatedPerAward(stakeInfo);
        _addrStake[msg.sender] = stakeInfo;
    }

    //计算全局
    function calculatedGobalPerAward() internal {
        uint256 blockNum = block.number - _lastBlockNumber;
        //1一个区块产生10个代币 在一个区间区块内所有质押的总量平均值
        _addPerTokenSpeed += 10 * blockNum * precision / _totalStaked;

        //更新区块高度
        _lastBlockNumber = block.number;
        emit Stake(msg.sender, _addPerTokenSpeed);
    }

    //计算每个用户
    function calculatedPerAward(StakeInfo storage stakeInfo) internal {
        stakeInfo.award += (_addPerTokenSpeed - stakeInfo.perTokenSpeed) * stakeInfo.ethCnt * precision;
        stakeInfo.perTokenSpeed = _addPerTokenSpeed;

        console.log(_addPerTokenSpeed);
    }

    /**
     * @dev 赎回质押的 ETH
     * @param amount 赎回数量
     */
    function unstake(uint256 amount) external {
        StakeInfo storage stakeInfo = _addrStake[msg.sender];
        require(stakeInfo.ethCnt >= amount, "no enough eth to return");
        stakeInfo.ethCnt -= amount;
        //重新计算奖励
        calculatedGobalPerAward();
        calculatedPerAward(stakeInfo);

        _addrStake[msg.sender] = stakeInfo;
        payable(msg.sender).sendValue(amount);

        emit Unstake(msg.sender, amount);
    }

    /**
     * @dev 领取 KK Token 收益
     */
    function claim() external {
        StakeInfo storage stakeInfo = _addrStake[msg.sender];
        //重新计算奖励
        calculatedGobalPerAward();
        calculatedPerAward(stakeInfo);

        stakeInfo.award = 0;
        //_kkToken.
        _kkToken.transferFrom(_kkToken.getAdmin(), msg.sender, stakeInfo.award);
    }

    /**
     * @dev 获取质押的 ETH 数量
     * @param account 质押账户
     * @return 质押的 ETH 数量
     */
    function balanceOf(address account) external view returns (uint256) {
        StakeInfo memory stakeInfo = _addrStake[account];
        return stakeInfo.ethCnt;
    }

    /**
     * @dev 获取待领取的 KK Token 收益
     * @param account 质押账户
     * @return 待领取的 KK Token 收益
     */
    function earned(address account) external view returns (uint256) {
        StakeInfo storage stakeInfo = _addrStake[account];
        uint256 blockNum = block.number - _lastBlockNumber;
        console.log("========");

        console.log(blockNum);
        console.log(_totalStaked);
        console.log(stakeInfo.perTokenSpeed);

        //uint256 _currentRewardsPerToken = currentRewardsPerToken + (block.number - lastUpdateBlock) * rate / totalStaked;

        //
        return stakeInfo.award
            + (10 * blockNum * precision / _totalStaked - stakeInfo.perTokenSpeed) * stakeInfo.ethCnt * precision;
    }
}
