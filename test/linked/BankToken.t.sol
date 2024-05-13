// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {BankToken} from "../../src/linked/BankToken.sol";

contract BankTokenTest is Test {
    BankToken bankToken;
    address[] addrArr;
    uint256 nonce = 100;

    function setUp() public {
        bankToken = new BankToken();
        for (uint256 i = 0; i < 15; i++) {
            address wallet = makeAddr(uintToString(i));
            addrArr.push(wallet);
        }
    }

    function test_execute() public {
        //先给地址钱包1个ETH

        for (uint256 index = 0; index < addrArr.length; index++) {
            uint256 randomNum = random();
            deal(addrArr[index], randomNum);
            vm.prank(addrArr[index]);
            //通过地址钱包给N个钱
            bankToken.depositETH{value: randomNum}();
            console.log("address: ", addrArr[index]);
            console.log("money: ", randomNum);
            // if (index == 5) {
            //     break;
            // }
        }
        // address k1 = bankToken._addressMap(address(0));
        // console.log("_addressMap key: ", k1);

        // k1 = bankToken._addressMap(k1);
        // console.log("_addressMap key: ", k1);

        // k1 = bankToken._addressMap(k1);
        // console.log("_addressMap key: ", k1);

        address[] memory top10Addr = bankToken.getTop10();
        for (uint256 index = 0; index < top10Addr.length; index++) {
            console.log("top10Addr: %s   money: %s", top10Addr[index], bankToken._addressEth(top10Addr[index]));
        }
    }

    // 生成伪随机数
    function random() public returns (uint256) {
        nonce++;
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 100;
        return randomNumber;
    }

    function uintToString(uint256 _num) public pure returns (string memory) {
        // 将 uint 转换为 bytes32
        bytes32 numBytes = bytes32(_num);

        // 初始化一个字符串缓冲区
        string memory str = new string(32);

        // 将 bytes32 转换为字符串
        assembly {
            // 获取字符串的指针
            let ptr := add(str, 32)

            // 将 bytes32 数据拷贝到字符串中
            mstore(ptr, numBytes)
        }

        return str;
    }
}
