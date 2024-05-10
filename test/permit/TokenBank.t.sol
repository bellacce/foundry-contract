// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import "../../src/permit/TokenERC2612.sol";
import "../../src/permit/SigUtils.sol";
import "../../src/permit/TokenBank.sol";

contract TokenBankTest is Test {
    TokenERC2612 internal tokenERC2612;
    TokenBank internal tokenBank;
    SigUtils internal sigUtils;

    address internal owner;
    address internal spender;

    function setUp() public {
        tokenERC2612 = new TokenERC2612("ENA", "ENA");
        tokenBank = new TokenBank();
    }

    function test_permitDeposit() public {
        sigUtils = new SigUtils(tokenERC2612.DOMAIN_SEPARATOR());

        //创造一个账户
        (address addrBob, uint256 privateKeyBob) = makeAddrAndKey("bob");
        tokenERC2612.transfer(addrBob, 100 * 10 ** 18);

        vm.startPrank(addrBob);

        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: addrBob,
            spender: address(tokenBank),
            value: 1e18,
            nonce: tokenERC2612.nonces(addrBob),
            deadline: 1 days
        });

        bytes32 digest = sigUtils.getTypedDataHash(permit);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKeyBob, digest);

        tokenBank.permitDeposit(
            address(tokenERC2612), permit.value, permit.deadline, v, r, s
        );

        assertEq(tokenBank.balanceOf(addrBob), 900 * 10 ** 18);
        assertEq(tokenBank.balanceOf(address(tokenBank)), 1e18);
    }
}
