// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket} from "../../src/deploy-test/NFTMarket.sol";
import {TokenBank} from "../../src/deploy-test/TokenBank.sol";
import {TokenHook} from "../../src/deploy-test/TokenHook.sol";
import {NFTToken} from "../../src/deploy-test/NFTToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// const { deployContract, link } = require('@openzeppelin/forge');
// const { Script, console } = require('forge-std/Script.sol');
//forge install OpenZeppelin/openzeppelin-contracts --no-commit
contract TokenHookTest is Test {
    NFTMarket public nFTMarket;
    TokenBank public tokenBank;
    TokenHook public tokenHook;
    NFTToken public nFTToken;
    address a;
    address b;

    function setUp() public {
        a = makeAddr("alice");

        tokenBank = new TokenBank();
        vm.prank(a);
        // console.log(msg.sender);

        tokenHook = new TokenHook();
        nFTToken = new NFTToken();

        nFTMarket = new NFTMarket(address(tokenHook), address(nFTToken));
    }

    //如果你只需要临时更改发送者，例如仅对单个函数调用进行测试，使用prank比较合适。会联系上下文传入
    // 如果你需要在多个函数调用或多个交易中持续模拟同一个发送者，那么使用startPrank会更加方便。
    function test_transferWithCallback() public {
        //1.创建合约部署用户
        // address a = makeAddr("alice");
        // address b = makeAddr("bob");

        //2.创建合约传递生命周期
        b = address(tokenBank);
        //3.测试tokenBank转移method
        vm.startPrank(a);
        console.log(msg.sender);

        vm.expectEmit(true, true, false, false);
        require(
            tokenHook.transferWithCallback(a, 1000, abi.encode(0)),
            "transfer failed"
        );

        tokenHook.transferWithCallback(b, 1000, abi.encode(0));
        assertEq(tokenBank.balanceOf(a), 1000, "not equal!");

        //捕获事件 不会indexd，true代表indexd，false表示不会不会，最后一个false代表其他
        vm.expectEmit(true, true, false, false);
        emit TokenHook.TransferWithCallback(a, b, 100);
        require(
            tokenHook.transferWithCallback(b, 1000, abi.encode(0)),
            "transfer failed"
        );

        //关闭合约
        vm.stopPrank();
    }
}
