// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

//可以通过 Metamask 等钱包直接给 Bank 合约地址存款
// 在 Bank 合约你查看每个地址的存款金额
// 编写 withdraw() 方法，仅管理员可以通过该方法提取资金。
// 用数组记录存款金额的前 3 名用户
// import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract BankToken {
    address public owner;
    address public admin;
    address[3] public top3;

    mapping(address => uint256) balanceOf;

    modifier Admin() {
        require(owner == msg.sender || admin == msg.sender, "is not auth!");
        _;
    }

    receive() external payable {}

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
        if (balanceOf[msg.sender] > balanceOf[top3[0]]) {
            // balanceOf(msg.sender);
            if (balanceOf[msg.sender] > balanceOf[top3[1]]) {
                if (balanceOf[msg.sender] > balanceOf[top3[2]]) {
                    top3[2] = msg.sender;
                } else {
                    top3[1] = msg.sender;
                }
            } else {
                top3[0] = msg.sender;
            }
        }
    }

    constructor() {
        admin = msg.sender;
    }

    function changeAdmin(address addr) external Admin {
        admin = addr;
    }

    function withdraw(uint256 amount) external Admin {
        require(address(this).balance >= amount, "Insufficient contract balance");
        payable(msg.sender).transfer(amount);
    }

    function getTop3() external view returns (address[] memory) {
        address[] memory topDepositsMemory = new address[](3);
        for (uint256 i = 0; i < top3.length; i++) {
            topDepositsMemory[i] = top3[i];
        }
        return topDepositsMemory;
    }
}
