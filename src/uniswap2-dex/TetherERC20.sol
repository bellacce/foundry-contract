// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TetherERC20 is ERC20 {
    constructor() ERC20("Tether usdt", "USDT") {
        _mint(msg.sender, 100000 * 10 ** 18);
    }
}
