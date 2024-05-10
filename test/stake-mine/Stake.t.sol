// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";

import "../../src/stake-mine/StakeMine.sol";
import "../../src/stake-mine/EsRntERC20.sol";
import "../../src/stake-mine/RntERC20.sol";

contract StakeTest is Test {
    RntERC20 _rntERC20;

    EsRntERC20 _esRntERC20;

    StakeMine _stakeMine;

    function setUp() public {}

    function test_stake() public {
        //创建初始用户
        address player1 = makeAddr("1");
        address player2 = makeAddr("2");

        address owner = makeAddr("owner");
        vm.startPrank(owner);

        _rntERC20 = new RntERC20("RNT", "RNT");
        //各转移的1000代币
        _rntERC20.transfer(player1, 1000 * 10 ** 18);
        _rntERC20.transfer(player2, 1000 * 10 ** 18);

        _esRntERC20 = new EsRntERC20();
        _stakeMine = new StakeMine(address(_rntERC20), address(_esRntERC20));
        //开始质押
        _stakeMine.stake(100 * 10 ** 18);

        vm.stopPrank();
    }
}
