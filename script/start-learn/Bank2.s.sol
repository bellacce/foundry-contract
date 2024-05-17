// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {BankToken} from "../../src/bank/BankToken.sol";

//forge script script/Counter.s.sol:CounterScript
// 部署脚本继承了Script合约
contract Bank2Script is Script {
    function setUp() public {}

    // 部署合约时会调用run()函数
    function run() public {
        // vm.broadcast();
        vm.startBroadcast();

        BankToken bankToken = new BankToken();

        vm.stopBroadcast();
    }
}
