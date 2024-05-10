// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EsRntERC20 is ERC20 {
    constructor() ERC20("esRNT", "esRNT") {
        //10 ** 18 代币最小单位
        _mint(msg.sender, 10000000 * 10 ** 18);
        //提前授权
        // approve(address(this), 1000 * 10 ** 18);
    }
}
