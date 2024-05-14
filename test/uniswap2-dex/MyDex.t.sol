// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import "../../src/uniswap2/UniswapV2Factory.sol";
import "../../src/uniswap2-dex/MyDex.sol";
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
        // address bob = makeAddr("bob");
        // address alice = makeAddr("alice");

        vm.startPrank(admin);
        deal(admin, 10 ether);

        (uint256 amountToken, uint256 amountETH, uint256 liquidity) = mydex.addLiquidityETH{value: 10 ether}(
            address(rntERC20), 10000, 8000, 10 ether, address(mydex), block.timestamp + 3600
        );
        console.log(amountToken);
        console.log(amountETH);
        console.log(liquidity);
        vm.stopPrank();

        //counter.increment();
        //assertEq(counter.number(), 1);
    }
}
