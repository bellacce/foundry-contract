// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./interfaces/IUniswapV2Factory.sol";
import "./UniswapV2Pair.sol";
import {Test, console} from "forge-std/Test.sol";

contract UniswapV2Factory is IUniswapV2Factory {
    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    // event PairCreated(address indexed token0, address indexed token1, address pair, uint256);
    //设置手续费的管理员，可任选一个钱包地址
    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, "UniswapV2: IDENTICAL_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), "UniswapV2: ZERO_ADDRESS");
        require(getPair[token0][token1] == address(0), "UniswapV2: PAIR_EXISTS"); // single check is sufficient
        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // console.log("==================1");
        // console.logBytes32(salt);
        // console.logBytes32(keccak256(abi.encodePacked(bytecode)));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        // console.log(pair);
        //Pair合约主要实现了三个方法：mint（添加流动性）、burn（移除流动性）、swap（兑换）。
        IUniswapV2Pair2(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, "UniswapV2: FORBIDDEN");
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, "UniswapV2: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }
}
