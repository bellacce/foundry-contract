// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./IEC20CallBack.sol";

contract TokenBank is IEC20CallBack {
    mapping(address => uint256) public balanceOf;

    event Deposit(address indexed _address, uint256 _amount);
    event Withdraw(address indexed _address, uint256 _amount);

    //转账到合约账户
    function tokensReceived(
        address sender,
        uint amount,
        bytes memory
    ) external returns (bool) {
        // 因为你这里只能存储单一的 token， 因此一定是一个固定的erc20 合约地址， 而不是ERC20合约就行， 不然还是可以继续伪造
        // require(msg.sender == address(), "no invalid address");
        //bank记录资金池
        balanceOf[sender] += amount;
        return true;
    }

    //1.存入token
    function deposit(address tokenAddress, uint256 _amount) external {
        //开通bank在ERC20的账户, 授权用户的token(来自于初始化合约的token)，并把一部分token转移到bank地址
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount);
        //bank记录资金池
        balanceOf[msg.sender] += _amount;
        emit Deposit(msg.sender, _amount);
    }

    //2.获取token
    function withdraw(address tokenAddress, uint256 tokenAmount) external {
        uint256 _amount = balanceOf[msg.sender];
        require(_amount > tokenAmount, "too many token to withdraw!");
        balanceOf[msg.sender] = 0;
        //资金转移
        IERC20(tokenAddress).transfer(msg.sender, tokenAmount);
        emit Withdraw(msg.sender, tokenAmount);
    }
}
