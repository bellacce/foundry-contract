// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./IToken.sol";

contract KKToken is IToken, ERC20 {
    address public admin;

    constructor() ERC20("KK", "KK") {
        admin = msg.sender;
    }

    modifier OnlyAdmin() {
        require(admin == msg.sender, "not auth use!");
        _;
    }

    function mint(address to, uint256 amount) external OnlyAdmin {
        _mint(to, amount);
    }

    function getAdmin() external view returns (address) {
        return admin;
    }
}
