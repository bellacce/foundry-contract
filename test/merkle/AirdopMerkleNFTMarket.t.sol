// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import "../../src/merkle/AirdopMerkleNFTMarket.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "../../src/merkle/NFTToken.sol";
import "../../src/merkle/TokenERC2612.sol";
import "../../src/permit/SigUtils.sol";

contract AirdopMerkleNFTMarketTest is Test {
    bytes32[] proof;
    bytes32 leaf;
    bytes32 merkleRoot;

    // address public _nftToken;
    // address public _tokenERC2612;

    function setUp() public {
        merkleRoot = bytes32(0x8c45324dfdb758b49298dd9d54a562dc9cbed8fb7c87bc3b7a8375a5fbb8d481);
        //proof.push(0xa8532aaa27e9f7c3a96d754674c99f1e2f824800);
        proof.push(0x72155ab19f64defdca605292f85d05e62580c41852b1bff9f02bd9cf4c4ac1ee);
        proof.push(0x66af34d373b909013012f47c2e8fcf962ed49c30d72ed525b8867e5fb5f9acbd);
    }

    //授权表示第三者进行购买 合约的币还是属于用户的 网络还是断了，测试会快很多
    function test_AirdopMerkleNFTMarket() public {
        //0x9BEF5148fD530244a14830f4984f2B76BCa0dC58
        //0x18ef5d5e78aa58a63503bcb48a563de61ffe7665d73ee22b4ab66ef15248be5a

        address alice = address(0x9BEF5148fD530244a14830f4984f2B76BCa0dC58); //alice的公钥
        address bob = address(0x8Aa8b0D84cf523923A459a6974C9499581d1F93D); //bob的公钥
        //组织者
        address owner = makeAddr("owner");
        vm.startPrank(owner);
        //ERC20 合约
        TokenERC2612 _tokenERC2612 = new TokenERC2612("test", "TS");
        //直接转移
        _tokenERC2612.transfer(alice, 1000);

        //NFT 合约
        NFTToken _nftToken = new NFTToken();

        AirdopMerkleNFTMarket airdopMerkleNFTMarket =
            new AirdopMerkleNFTMarket(merkleRoot, address(_nftToken), address(_tokenERC2612));
        vm.stopPrank();

        //1. 转移alice 1000 个token 授权给用户
        vm.startPrank(alice);

        SigUtils sigUtils = new SigUtils(_tokenERC2612.DOMAIN_SEPARATOR());

        uint256 _deadline = block.timestamp + 1 days;
        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: alice,
            spender: address(airdopMerkleNFTMarket),
            value: 1000,
            nonce: 0,
            deadline: _deadline
        });
        bytes32 digest = sigUtils.getTypedDataHash(permit);
        (uint8 v, bytes32 r, bytes32 s) =
            vm.sign(0x18ef5d5e78aa58a63503bcb48a563de61ffe7665d73ee22b4ab66ef15248be5a, digest);
        vm.stopPrank();

        // _tokenERC2612.permit(permit.owner, permit.spender, permit.value, permit.deadline, v, r, s);

        //2. bob 铸造一个nft并上架 授权给用户
        vm.startPrank(bob);
        uint256 nftId = _nftToken.mint(bob, "wwww.google.com");
        _nftToken.approve(address(airdopMerkleNFTMarket), nftId);
        airdopMerkleNFTMarket.list(nftId, 1000);
        vm.stopPrank();

        //3.alice是白名单用户，要靠资金买的
        vm.startPrank(alice);
        bool flag = airdopMerkleNFTMarket.multicall(proof, nftId, 1000, _deadline, v, r, s);
        require(flag, "multicall error!");
        vm.stopPrank();
    }

    function test_sign() public {
        NFTToken _nftToken = new NFTToken();
        TokenERC2612 _tokenERC2612 = new TokenERC2612("test", "TS");

        AirdopMerkleNFTMarket airdopMerkleNFTMarket =
            new AirdopMerkleNFTMarket(merkleRoot, address(_nftToken), address(_tokenERC2612));
        address alice = address(0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02); //alice的公钥

        bool flag = airdopMerkleNFTMarket.verifyWhitelist(proof, alice);
        assertEq(true, flag);
    }

    // function testSign() public {
    //     address alice = address(0x9BEF5148fD530244a14830f4984f2B76BCa0dC58); //alice的公钥
    //     address bob = address(0x8Aa8b0D84cf523923A459a6974C9499581d1F93D); //bob的公钥
    //     bytes32 hash = keccak256("Signed by Alice"); //信息hash值
    //     (uint8 v, bytes32 r, bytes32 s) =
    //         vm.sign(0x18ef5d5e78aa58a63503bcb48a563de61ffe7665d73ee22b4ab66ef15248be5a, hash); //使用的alice的私钥、hash进行签名
    //     address signer = ecrecover(hash, v, r, s);

    //     emit log_named_address("address", signer);
    //     assertEq(alice, signer);

    //     (uint8 v2, bytes32 r2, bytes32 s2) =
    //         vm.sign(0x4e1518672e45fb2746ec5a217330ed24d815d44537da647e973c06d0b0069053, hash); //bob的私钥
    //     address signer2 = ecrecover(hash, v2, r2, s2); //使用的ECDSA recover 函数得到签名地址

    //     emit log_named_address("address", signer2);
    //     assertEq(bob, signer2);
    // }
}
