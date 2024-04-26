// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;


interface IEC20CallBack {

    function tokensReceived(address sender, uint amount, bytes memory tokenId) external returns (bool);
    
}