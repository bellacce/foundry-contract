// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 编写一个 Bank 存款合约，实现功能：

// 1. 可以通过 Metamask 等钱包直接给 Bank 合约地址存款
// 2. 在 Bank 合约里记录了每个地址的存款金额
// 3. 用可迭代的链表保存存款金额的前 10 名用户

contract BankToken {
    mapping(address => address) _addressMap;

    mapping(address => uint256) _addressEth;

    address constant GUARD = address(0);

    uint256 public listSize = 1;

    constructor() {
        _addressMap[GUARD] = GUARD;
    }

    //给合约地址转账
    receive() external payable {
        address firstAddr = _addressMap[GUARD];
        //获取map的金额
        _addressEth[msg.sender] += msg.value;
        uint256 ethCnt = _addressEth[msg.sender];

        if (firstAddr == GUARD) {
            _addressMap[GUARD] = msg.sender;
            return;
        }
        address nextAddr = _addressMap[GUARD];
        // address nextAddr = _addressMap[beforeAddr];
        for (uint256 index = 0; index < listSize; index++) {
            // top10Addr[index] = nextAddr;
            uint256 amount = _addressEth[nextAddr];
            if (ethCnt >= amount && nextAddr != msg.sender) {
                //断开链表 插入地址
                _addressMap[nextAddr] = msg.sender;
                _addressMap[msg.sender] = nextAddr;
            }
            nextAddr = _addressMap[nextAddr];
        }
        listSize++;
    }

    function getTop10() public view returns (address[] memory top10Addrs) {
        require(listSize > 10, "no enough address to list top10!");
        address[] memory top10Addr = new address[](10);
        address nextAddr = _addressMap[GUARD];
        for (uint256 index = 0; index < 10; index++) {
            top10Addr[index] = nextAddr;
            nextAddr = _addressMap[nextAddr];
        }
        return top10Addr;
    }

    // 获取合约账户余额
    function getBalanceOfContract() public view returns (uint256) {
        return address(this).balance;
    }
}
