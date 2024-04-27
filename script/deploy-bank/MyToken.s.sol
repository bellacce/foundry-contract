// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../../src/deploy-bank/MyToken.sol";

//forge script script/Counter.s.sol:CounterScript
// 部署脚本继承了Script合约
contract MyTokenScript is Script {

    string name = "Enjoy Zero X";
    string symbol = "EZX";
    MyToken myToken;

    function setUp() public {}

    // 部署合约时会调用run()函数
    function run() public {
        // vm.broadcast();
        vm.startBroadcast();

        console.log("msg.sender:",msg.sender);
        myToken = new MyToken(name, symbol);

        // address b = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        address b = 0x457b4b8934c354b4c0435a715D300Ce204FA16eA;
        require(myToken.balanceOf(b) == 1e10*1e18, "is not equal!");
        vm.stopBroadcast();
    }
}
