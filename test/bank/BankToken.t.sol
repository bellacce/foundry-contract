// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {StakingPool} from "../../src/stakeEth/StakingPool.sol";
import {BankToken} from "../../src/bank/BankToken.sol";

// const { deployContract, link } = require('@openzeppelin/forge');
// const { Script, console } = require('forge-std/Script.sol');
//forge install OpenZeppelin/openzeppelin-contracts --no-commit
contract BankTokenTest is Test {
    function setUp() public {}

    function test_execute() public {
        address a = makeAddr("a");
        vm.startPrank(a);
        BankToken bankToken = new BankToken();

        vm.stopPrank();

        address b = makeAddr("b");
        vm.deal(b, 10 ether);
        vm.prank(b);
        bankToken.deposit{value: 2 ether}();

        //counter.increment();
        //assertEq(counter.number(), 1);
    }
}
