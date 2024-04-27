// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket} from "../../src/deploy-test/NFTMarket.sol";
import {TokenBank} from "../../src/deploy-test/TokenBank.sol";
import {TokenHook} from "../../src/deploy-test/TokenHook.sol";


// const { deployContract, link } = require('@openzeppelin/forge');
// const { Script, console } = require('forge-std/Script.sol');
//forge install OpenZeppelin/openzeppelin-contracts --no-commit
contract BankTest is Test {
    NFTMarket public nFTMarket;
    TokenBank public tokenBank;
    TokenHook public tokenHook;


    function setUp() public {
        nFTMarket = new NFTMarket();
        tokenBank = new TokenBank();
        tokenHook = new TokenHook();
    }

    //vm.prank(address) 零时修改 改变下一次调用的msg.sender,只改变下一次调用
    // 如果后面的调用也一直保持修改，使用vm.startPrank(alice); vm.stopPrank();
    //deal(address who, uint256 newBalance) 改变who地址的余额。
    function test_depositETH() public {
                vm.prank(b);


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

        //打开事件
        vm.expectEmit();
        emit Bank.Deposit(address(0), 0.5 ether);


        //bytes4 solector = bytes4(keccak256(""));
       // abi.encodeWithSelector(bank.depositETH., msg.sender, 12);
        // vm.stopPrank();
        
    }

    function test_fail_depositETH() public {
        address b = makeAddr("alice");
        vm.prank(b);
        vm.expectRevert("Deposit amount must be greater than 0");
        bank.depositETH();

    }

}
