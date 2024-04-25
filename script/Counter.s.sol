// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

//forge script script/Counter.s.sol:CounterScript
// 部署脚本继承了Script合约
contract CounterScript is Script {
    function setUp() public {}

    // 部署合约时会调用run()函数
    function run() public {
        vm.broadcast();
    }
}
