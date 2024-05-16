// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {Test, console} from "forge-std/Test.sol";
import "../../src/uniswap2/UniswapV2Factory.sol";
import "../../src/uniswap2-dex/MyDex.sol";
import {WETHCoin} from "../../src/uniswap2-dex/WETHCoin.sol";
import {TetherERC20} from "../../src/uniswap2-dex/TetherERC20.sol";

// contract TetherERC20 is ERC20 {
//     constructor() ERC20("Tether usdt", "USDT") {
//         _mint(msg.sender, 10000000 * 10 ** 18);
//     }
// }

contract MyDex2Test is Test {
    address admin;
    MyDex mydex;
    WETHCoin wethCoin;
    TetherERC20 tetherERC20;
    UniswapV2Factory factory;

    function setUp() public {
        admin = makeAddr("admin");
        vm.startPrank(admin);
        wethCoin = new WETHCoin();
        tetherERC20 = new TetherERC20();
        factory = new UniswapV2Factory(admin);
        mydex = new MyDex(address(factory), address(wethCoin));
        vm.stopPrank();
    }

    function test_trade_usdt() public {
        address bob = makeAddr("bob");
        address alice = makeAddr("alice");

        vm.startPrank(admin);
        //先充钱
        // rntERC20.approve(address(rntERC20), 10000);
        // 谁调用transfer，如果拥有钱的人调用，不需要授权，授权是指别人用你的钱
        tetherERC20.transfer(bob, 30000);
        tetherERC20.transfer(alice, 30000);

        //  console.log(wethCoin.balanceOf(admin));
        // wethCoin.deposit{value: 10 ether}();

        vm.startPrank(bob);
        //添加ether
        deal(bob, 10 ether);

        //1. 先创建交易对
        factory.createPair(address(tetherERC20), address(wethCoin));

        //2.授权给myDex操作
        tetherERC20.approve(address(mydex), 30000);
        wethCoin.approve(address(mydex), 10 ether);

        //3.添加流动性
        uint256 deadline = block.timestamp + 3600;
        //    10000*10 / 11 * 10000 计算：10个WETH兑换的RNT的数量9090
        // (uint256 amountToken, uint256 amountETH, uint256 liquidity) =
        mydex.addLiquidityETH{value: 10 ether}(address(tetherERC20), 30000, 25000, 10 ether, bob, deadline);
        console.log("boobbb");

        console.log(tetherERC20.balanceOf(bob));
        vm.stopPrank();

        vm.startPrank(alice);
        //1.兑换USDT > WETH
        tetherERC20.approve(address(mydex), 4000);
        mydex.buyETH(address(tetherERC20), 4000, 1 ether);
        vm.stopPrank();

        address lucy = makeAddr("lucy");
        deal(lucy, 1 ether);
        vm.startPrank(lucy);
        //2.兑换WETH > USDT
        wethCoin.approve(address(mydex), 1 ether);
        mydex.sellETH{value: 1 ether}(address(tetherERC20), 1000);
        vm.stopPrank();

        //counter.increment();
        //assertEq(counter.number(), 1);
    }
}
