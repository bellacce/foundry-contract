// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RntERC20 is ERC20 {
    constructor() ERC20("Rent N T", "RNT") {
        _mint(msg.sender, 10000 * 10 ** 18);
    }
}
