// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../../src/start-learn/Bank.sol";
import {CusERC20} from "../../src/start-learn/CusERC20.sol";

// const { deployContract, link } = require('@openzeppelin/forge');
// const { Script, console } = require('forge-std/Script.sol');
//forge install OpenZeppelin/openzeppelin-contracts --no-commit
contract BankTest is Test {
    Bank public bank;
    CusERC20 public erc20;


    function setUp() public {
        erc20 = new CusERC20();
        bank = new Bank(erc20);
    }

    //vm.prank(address) 零时修改 改变下一次调用的msg.sender,只改变下一次调用
    // 如果后面的调用也一直保持修改，使用vm.startPrank(alice); vm.stopPrank();
    //deal(address who, uint256 newBalance) 改变who地址的余额。
    function test_depositETH() public {
        //bank.
        address b = makeAddr("alice");
        vm.prank(b);
        erc20.mint(b, 1000); 
        //先给地址钱包1个ETH
        deal(b,1 ether);
         vm.prank(b);
         //通过地址钱包给1个ETH
        bank.depositETH{value:1 ether}();
        assertEq(bank.balanceOf(b), 1 ether);
        // vm.stopPrank();
    }

    function test_fail_depositETH() public {
        address b = makeAddr("alice");
        vm.prank(b);
        vm.expectRevert("Deposit amount must be greater than 0");
        bank.depositETH();

    }

}
