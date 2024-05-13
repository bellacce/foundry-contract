pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//1.使用 EIP2612 标准（可基于 Openzepplin 库）编写一个自己名称的 Token 合约。
contract TokenERC20 is ERC20 {
    // 构造函数，接受代币名称和代币符号作为参数，并初始化合约
    constructor() ERC20("TESSSS", "TS") {
        // 发行 100000 个代币，10 的 18 次方是以太坊中代币的最小单位
        _mint(msg.sender, 100000 * 10 ** 18);
    }
}
