// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./TokenERC20.sol";

//编写 IDO 合约，实现 Token 预售，需要实现如下功能：

// 开启预售: 支持对给定的任意ERC20开启预售，设定预售价格，募集ETH目标，超募上限，预售时长。
// 任意用户可支付ETH参与预售；
// 预售结束后，如果没有达到募集目标，则用户可领会退款；
// 预售成功，用户可领取 Token，且项目方可提现募集的ETH；
// 提交要求

// 编写 IDO 合约 和对应的测试合约
// 截图 foundry test 测试执行结果
// 提供 github IDO合约源码链接

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract IdoRaise {
    using Address for address payable;

    uint256 public _price;
    uint256 public _targetAmountETH;
    uint256 public _overAmount;
    uint256 public _startTime;
    uint256 public _endTime;
    address public _tokenCoinAddr;

    address admin;

    //参数人
    address[] private _tokenAddressArr;
    //参数的人的统计
    mapping(address => uint256) _tokenAddressMap;
    //累计收集token的数量
    uint256 public _tokenTotal;

    constructor() {
        admin = msg.sender;
    }

    //累计eth的数量
    function getEthBalance() public view returns (uint256) {
        return address(this).balance;
    }

    event BuyTokens(address addr, uint256 num1, uint256 num2);
    //1.预售购买 最小单位wei

    function buyTokens() external payable {
        emit BuyTokens(msg.sender, _tokenTotal, _price);

        //设置在预售期间购买
        require(block.timestamp >= _startTime && block.timestamp <= _endTime, "Presale not active");

        uint256 addrPay = _tokenTotal * _price;
        //募集资金超过上限 预售已完成

        require(_overAmount > (addrPay + address(this).balance), "fund to over!");

        //获取token
        require(msg.value > 0, "must add pay money");
        emit BuyTokens(msg.sender, msg.value, _price);

        uint256 amount = msg.value / _price;

        //添加参与人数
        if (_tokenAddressMap[msg.sender] == 0) {
            _tokenAddressArr.push(msg.sender);
        }
        _tokenAddressMap[msg.sender] += amount;
        _tokenTotal += amount;

        //token和eth换算
        emit BuyTokens(msg.sender, _tokenTotal, _price);
    }

    event Refund(address from, address to, string msg);
    //2.用户退款

    function refund() external onlyAdmin returns (bool) {
        //预售是否结束
        require(block.timestamp > _endTime, "presell not finish to fund!");
        //募集资金是否不足
        require(_overAmount > address(this).balance, "fund to over!");

        uint256[] memory tokenCnt = new uint256[](_tokenAddressArr.length);
        for (uint256 i = 0; i < _tokenAddressArr.length; i++) {
            tokenCnt[i] = _tokenAddressMap[_tokenAddressArr[i]];
            //开始退款
            payable(_tokenAddressArr[i]).transfer(tokenCnt[i] * _price); //之后会自动调用receive
        }
        emit Refund(admin, msg.sender, "refund finished!");

        return true;
    }

    //3.提现募集
    function withDraw() external onlyAdmin {
        require(address(this).balance > _targetAmountETH, "not enough eth amount!");
        //提现到目标账户
        payable(msg.sender).sendValue(address(this).balance); //项目方提现
    }

    //预售价格 //募集ETH目标  // 超募上限 //预售时长
    function mintProject(
        uint256 price,
        uint256 targetAmountETH,
        uint256 overAmount,
        uint256 startTime,
        uint256 endTime,
        address tokenCoinAddr
    ) public onlyAdmin {
        //设置预售规则
        _price = price;
        _targetAmountETH = targetAmountETH;
        _overAmount = overAmount;
        _startTime = startTime;
        _endTime = endTime;
        _tokenCoinAddr = tokenCoinAddr;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }
}
