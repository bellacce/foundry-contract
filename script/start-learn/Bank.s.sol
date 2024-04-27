// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {Bank} from "../../src/start-learn/Bank.sol";
import {CusERC20} from "../../src/start-learn/CusERC20.sol";

//forge script script/Counter.s.sol:CounterScript
// 部署脚本继承了Script合约
contract BankScript is Script {
    function setUp() public {}

    // 部署合约时会调用run()函数
    function run() public {
        // vm.broadcast();
        vm.startBroadcast();

        CusERC20 cusERC20 = new CusERC20();

         //bank.
        address b = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        cusERC20.mint(b, 1 ether);
         //通过地址钱包给1个ETH
        //ank.depositETH{value:1 ether}();
        require(cusERC20.balanceOf(b) > 1 ether, "is not equal!");
    }
}
