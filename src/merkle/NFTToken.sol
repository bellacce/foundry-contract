// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./CusEIP721Permit.sol";

// import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract NFTToken is ERC721 {
    uint256 private _currentTokenId;

    mapping(uint256 tokenId => string) private _tokenURIs;

    constructor() ERC721("open stack", "OS") {}

    // 0x74b73FD5B6A4d5A1Bb63f713997A9CBb1dF54815
    // https://orange-naval-clownfish-219.mypinata.cloud/ipfs/QmVZn4L3VTtQV57CxWhkNbD7mD24QfXsZKvJApEYSxpRVF
    function mint(address to, string memory tokenURI) external returns (uint256 tokenId) {
        uint256 newTokenId = _getNextTokenId();
        _safeMint(to, newTokenId);
        _tokenURIs[newTokenId] = tokenURI;
        _incrementTokenId();
        return newTokenId;
    }

    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId + 1;
    }

    function _incrementTokenId() private {
        _currentTokenId++;
    }
}
