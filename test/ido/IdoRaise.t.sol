// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {IdoRaise} from "../../src/ido/IdoRaise.sol";
import {TokenERC20} from "../../src/ido/TokenERC20.sol";

contract IdoRaiseTest is Test {
    address admin;
    TokenERC20 tokenERC20;
    IdoRaise idToAl;

    function setUp() public {
        admin = makeAddr("admin");
        vm.startPrank(admin);
        tokenERC20 = new TokenERC20();
        idToAl = new IdoRaise();
        vm.stopPrank();
    }

    function test_buyTokens() public {
        // 定义预售参数
        uint256 price = 100;
        uint256 targetAmountETH = 10 ether; //募集 ETH 目标
        uint256 overAmount = 15 ether; // 超募上限
        // uint256 startTime = block.timestamp + 3600; // 一小时后
        uint256 startTime = block.timestamp; // 测试可以买币

        uint256 endTime = startTime + 3600 * 24; // 开始时间后一天

        vm.prank(admin);
        // 调用合约的 mintProject 方法
        idToAl.mintProject(price, targetAmountETH, overAmount, startTime, endTime, address(tokenERC20));
        //创建alice和bob
        address alice = makeAddr("alice");
        deal(alice, 1 ether);
        vm.prank(alice);
        idToAl.buyTokens{value: 1 ether}();

        address bob = makeAddr("bob");
        deal(bob, 14 ether);
        vm.prank(bob);
        idToAl.buyTokens{value: 12 ether}();

        assertEq(idToAl.getEthBalance(), 13 ether, "not equal!");
    }

    function test_refund() public {
        // 定义预售参数
        uint256 price = 100;
        uint256 targetAmountETH = 10 ether; //募集 ETH 目标
        uint256 overAmount = 15 ether; // 超募上限
        // uint256 startTime = block.timestamp + 3600; // 一小时后
        uint256 startTime = block.timestamp; // 测试可以买币

        uint256 endTime = startTime + 3600 * 24; // 开始时间后一天

        vm.prank(admin);
        // 调用合约的 mintProject 方法
        idToAl.mintProject(price, targetAmountETH, overAmount, startTime, endTime, address(tokenERC20));
        //创建alice和bob
        address alice = makeAddr("alice");
        deal(alice, 1 ether);
        vm.prank(alice);
        idToAl.buyTokens{value: 1 ether}();

        address bob = makeAddr("bob");
        deal(bob, 14 ether);
        vm.prank(bob);
        idToAl.buyTokens{value: 8 ether}();

        vm.startPrank(admin);
        //募资没到退款
        idToAl.mintProject(price, targetAmountETH, overAmount, startTime, 0, address(tokenERC20));

        assertEq(idToAl.refund(), true);
        vm.stopPrank();
    }
}
