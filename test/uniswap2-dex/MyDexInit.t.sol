// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import "../../src/uniswap2/UniswapV2Pair.sol";
import "../../src/uniswap2-dex/MyDex.sol";
import {RntERC20} from "../../src/uniswap2-dex/RNTERC20.sol";
import {WETHCoin} from "../../src/uniswap2-dex/WETHCoin.sol";

contract MyDexInitTest is Test {
    function setUp() public {}

    function test_execute() public view {
        // address RNTtoken = 0x32850cAd1e9170614704fF8BA37a25e498e1B832;
        // address WETH = 0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4;
        // address tokenA = 0x32850cAd1e9170614704fF8BA37a25e498e1B832;
        // address tokenB = 0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4;
        // (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);

        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(bytecode));

        console.logBytes32(salt);
        console.logBytes32(hex"7853c7ef4043f4ba9809d94dae9b08fa0b2fe47a244a1e6524e39953d307a87f");
        // console.logBytes(bytecode);
        // require(salt);
        // require(bytecode);
    }
}
