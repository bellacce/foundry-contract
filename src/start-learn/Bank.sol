// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./CusERC20.sol";

contract Bank {
    CusERC20 public token;

    //初始化获取ERC20地址
    constructor(CusERC20 _token) {
        token = _token;
    }

    mapping(address => uint256) public balanceOf;

    event Deposit(address indexed user, uint256 amount);

    function depositETH() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}
