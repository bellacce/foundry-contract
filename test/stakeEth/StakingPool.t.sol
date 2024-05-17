// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {StakingPool} from "../../src/stakeEth/StakingPool.sol";
import {KKToken} from "../../src/stakeEth/KKToken.sol";

// const { deployContract, link } = require('@openzeppelin/forge');
// const { Script, console } = require('forge-std/Script.sol');
//forge install OpenZeppelin/openzeppelin-contracts --no-commit
contract StakingPoolTest is Test {
    KKToken kkToken;
    StakingPool stakingPool;
    address admin;

    function setUp() public {
        admin = makeAddr("admin");
        vm.startPrank(admin);
        kkToken = new KKToken();
        stakingPool = new StakingPool(address(kkToken));
        vm.stopPrank();
    }

    function test_execute() public {
        address bob = makeAddr("bob");
        address alice = makeAddr("alice");

        vm.startPrank(admin);
        //添加ether
        deal(admin, 10 ether);
        stakingPool.stake{value: 10 ether}();

        kkToken.mint(admin, 100000);
        kkToken.approve(address(stakingPool), 100000);

        vm.stopPrank();
        console.log(block.number);

        vm.startPrank(bob);
        //添加ether
        deal(bob, 10 ether);
        vm.roll(block.number + 1); // 快进1个区块
        stakingPool.stake{value: 10 ether}();
        vm.roll(block.number + 3); // 快进1个区块
        // stakingPool.claim();
        vm.stopPrank();

        console.log(stakingPool.balanceOf(bob));
        console.log(stakingPool.earned(bob));

        // vm.startPrank(alice);
        // vm.roll(block.number + 5); // 快进2个区块

        // //添加ether
        // deal(alice, 10 ether);
        // stakingPool.stake{value: 10 ether}();
        // vm.roll(block.number + 8); // 快进2个区块
        // stakingPool.claim();

        // vm.stopPrank();
        // console.log(stakingPool.balanceOf(alice));
        // console.log(stakingPool.earned(alice));

        // assertEq(kkToken.balanceOf(bob), 10);
    }
}
