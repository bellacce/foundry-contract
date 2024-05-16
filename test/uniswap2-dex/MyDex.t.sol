// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import "../../src/uniswap2/UniswapV2Factory.sol";
import "../../src/uniswap2-dex/MyDex.sol";
// import "../../src/uniswap2-dex/TetherERC20.sol";
import {RntERC20} from "../../src/uniswap2-dex/RNTERC20.sol";
import {WETHCoin} from "../../src/uniswap2-dex/WETHCoin.sol";

contract MyDexTest is Test {
    address admin;
    RntERC20 rntERC20;
    MyDex mydex;
    WETHCoin wethCoin;
    UniswapV2Factory factory;

    function setUp() public {
        admin = makeAddr("admin");
        vm.startPrank(admin);
        rntERC20 = new RntERC20();
        wethCoin = new WETHCoin();
        factory = new UniswapV2Factory(admin);
        mydex = new MyDex(address(factory), address(wethCoin));
        vm.stopPrank();
    }

    function test_execute() public {
        address bob = makeAddr("bob");
        vm.startPrank(admin);
        // address alice = makeAddr("alice");
        //先充钱
        // rntERC20.approve(address(rntERC20), 10000);
        // 谁调用transfer，如果拥有钱的人调用，不需要授权，授权是指别人用你的钱
        rntERC20.transfer(bob, 10000);

        //  console.log(wethCoin.balanceOf(admin));
        // wethCoin.deposit{value: 10 ether}();

        vm.startPrank(bob);
        //添加ether
        deal(bob, 10 ether);

        //1. 先创建交易对
        address pair = factory.createPair(address(rntERC20), address(wethCoin));

        //2.授权给myDex操作
        rntERC20.approve(address(mydex), 10000);
        wethCoin.approve(address(mydex), 1 ether);
        //3.添加流动性
        (uint256 amountToken, uint256 amountETH, uint256 liquidity) = mydex.addLiquidityETH{value: 10 ether}(
            address(rntERC20), 10000, 8000, 10 ether, bob, block.timestamp + 3600
        );
        console.log("==========");
        console.log(amountToken);
        console.log(amountETH);
        console.log(liquidity);

        //4.移除流动性
        IUniswapV2Pair(pair).approve(address(mydex), liquidity);
        (uint256 amountTokenRT, uint256 amountETHRT) =
            mydex.removeLiquidityETH(address(rntERC20), liquidity, 8000, 1 ether, bob, block.timestamp + 3600);
        console.log(amountTokenRT);
        console.log(amountETHRT);
        vm.stopPrank();

        //counter.increment();
        //assertEq(counter.number(), 1);
    }

    function test_trade() public {
        address bob = makeAddr("bob");
        address alice = makeAddr("alice");

        vm.startPrank(admin);
        //先充钱
        // rntERC20.approve(address(rntERC20), 10000);
        // 谁调用transfer，如果拥有钱的人调用，不需要授权，授权是指别人用你的钱
        rntERC20.transfer(bob, 10000);
        rntERC20.transfer(alice, 10000);

        //  console.log(wethCoin.balanceOf(admin));
        // wethCoin.deposit{value: 10 ether}();

        vm.startPrank(bob);
        //添加ether
        deal(bob, 10 ether);

        //1. 先创建交易对
        address pair = factory.createPair(address(rntERC20), address(wethCoin));

        //2.授权给myDex操作
        rntERC20.approve(address(mydex), 10000);
        wethCoin.approve(address(mydex), 10 ether);
        //3.添加流动性
        uint256 deadline = block.timestamp + 3600;
        //    10000*10 / 11 * 10000 计算：10个WETH兑换的RNT的数量9090
        (uint256 amountToken, uint256 amountETH, uint256 liquidity) =
            mydex.addLiquidityETH{value: 10 ether}(address(rntERC20), 10000, 8000, 10 ether, bob, deadline);
        console.log("boobbb");

        console.log(rntERC20.balanceOf(bob));
        vm.stopPrank();

        vm.startPrank(alice);
        //兑换RNT > WETH
        address[] memory path = new address[](2);
        path[0] = address(rntERC20); // 假设第一个代币地址
        path[1] = address(wethCoin); // 假设第二个代币地址
        rntERC20.approve(address(mydex), 1000);
        uint256[] memory amounts = mydex.swapExactTokensForTokens(1000, 906610893880149131, path, alice, deadline);
        console.log(amounts.length);
        vm.stopPrank();

        address lucy = makeAddr("lucy");
        deal(lucy, 1 ether);
        vm.startPrank(lucy);
        //兑换RNT > WETH
        path = new address[](2);
        path[0] = address(wethCoin); // 假设第一个代币地址
        path[1] = address(rntERC20); // 假设第二个代币地址
        wethCoin.approve(address(mydex), 1 ether);
        amounts = mydex.swapExactETHForTokens{value: 1 ether}(906, path, lucy, deadline);
        console.log(amounts.length);
        vm.stopPrank();

        //counter.increment();
        //assertEq(counter.number(), 1);
    }
}
