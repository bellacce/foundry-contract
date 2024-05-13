// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "./NFTToken.sol";
import "./TokenERC2612.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

// ### **题目#1**

// 实现一个 AirdopMerkleNFTMarket 合约(假定 Token、NFT、AirdopMerkleNFTMarket 都是同一个开发者开发)，功能如下：

// 1. 基于 Merkel 树验证某用户是否在白名单中
// 2. 在白名单中的用户可以使用上架（和之前的[上架逻辑](https://decert.me/challenge/5f11aa15-b101-480b-91b5-4888b9aafdbb)一致）
// 指定价格的优惠 50% 的Token 来购买 NFT， Token 需支持 permit 授权。

// 要求使用 multicall( delegateCall 方式) 一次性调用两个方法：
// 指定价格的优惠 50% 的Token 来购买 NFT， Token 需支持 permit 授权。
// 1. `permitPrePay()` : 调用token的 permit 进行授权
// 2. `claimNFT()` : 通过默克尔树验证白名单，并利用 permitPrePay 的授权，转入 token 转出 NFT 。

// 请贴出你的代码 github ，代码需包含合约，multicall 调用封装，Merkel 树的构建以及测试用例。

//abi.encodeWithSignature和abi.encode的区别

//todo nft市场包含哪些内容，还需要明确
contract AirdopMerkleNFTMarket {
    mapping(uint256 nftId => address account) public _nftHolder;
    mapping(uint256 nftId => uint256 amount) public _nftPrice;

    //NFT market持有token的累计
    mapping(address => uint256) public balanceOfToken;

    bytes32 public _merkleRoot;
    address public _nftToken;
    address public _tokenERC2612;

    function onERC721Received(address, address, uint256, bytes calldata) public pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    constructor(bytes32 merkleRoot, address nftToken, address tokenERC2612) {
        _merkleRoot = merkleRoot;
        _tokenERC2612 = tokenERC2612;
        _nftToken = nftToken;
    }

    //1.先上架
    function list(uint256 nftId, uint256 amount) public {
        NFTToken(_nftToken).safeTransferFrom(msg.sender, address(this), nftId);
        _nftHolder[nftId] = msg.sender;
        _nftPrice[nftId] = amount;
    }

    // Verify whitelist：proof：待验证的地址，addr=leaf叶子节点
    function verifyWhitelist(bytes32[] memory proof, address addr) public view returns (bool) {
        return MerkleProof.verify(proof, _merkleRoot, keccak256(abi.encodePacked(addr)));
    }

    //授权
    function permitPrePay(uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
        IERC20Permit(_tokenERC2612).permit(msg.sender, address(this), amount, deadline, v, r, s);
    }

    function claimNFT(bytes32[] memory proof, uint256 nftId) public {
        //验证是不是白名单里面
        bool isWhite = verifyWhitelist(proof, msg.sender);
        if (isWhite) {
            //转入token
            TokenERC2612(_tokenERC2612).transferFrom(msg.sender, _nftHolder[nftId], _nftPrice[nftId] / 2);
            //拥有token的人获得token金额
            balanceOfToken[_nftHolder[nftId]] += _nftPrice[nftId] / 2;
        } else {
            //转入token
            TokenERC2612(_tokenERC2612).transferFrom(msg.sender, _nftHolder[nftId], _nftPrice[nftId]);
            //拥有token的人获得token金额
            balanceOfToken[_nftHolder[nftId]] += _nftPrice[nftId];
        }
        //转到对方NFT
        NFTToken(_nftToken).transferFrom(address(this), msg.sender, nftId);
        _nftHolder[nftId] = msg.sender;
    }

    // multicall 调用permitPrePay和claimNFT
    function multicall(bytes[] calldata data) external returns (bytes[] memory results) {
        // 声明一个数组来存储调用返回值
        results = new bytes[](data.length);
        // 遍历传进来的需要去调用的方法字节数组
        for (uint256 i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);
            require(success, "Delegatecall failed");
            results[i] = result;
        }
        return results;
    }
}
