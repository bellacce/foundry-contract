//SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IEC20CallBack.sol";

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}

contract TokenHook is ERC20 {
    using Address for address;
    event TransferWithCallback(
        address indexed from,
        address indexed to,
        uint256 amount
    );

    constructor() ERC20("openspace", "OS") {
        _mint(msg.sender, 10000000 * 10 ** 18);
    }

    //recipient  自定义bank的合约地址 或者NFT合约
    function transferWithCallback(
        address recipient,
        uint256 amount,
        bytes calldata data
    ) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        emit TransferWithCallback(msg.sender, recipient, amount);
        if (recipient.isContract()) {
            bool rv = IEC20CallBack(recipient).tokensReceived(
                msg.sender,
                amount,
                data
            );
            require(rv, "No tokensReceived");
        }
        return true;
    }

    function changeUintToBytes(
        uint256 cnt
    ) public pure returns (bytes memory data) {
        bytes memory encoded = abi.encode(cnt);
        return encoded;
    }
}
