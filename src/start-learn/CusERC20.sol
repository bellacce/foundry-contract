// SPDX-License-Identifier: MIT 
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CusERC20 is ERC20 {

    address public owner;

    mapping(address account => uint256) private _balances;

    constructor() ERC20("AMM WORLD", "AW") {
        // 将所有供应的token转入合约创建者的账户余额
        _mint(msg.sender, 10000 * 10 ** 18);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

} 