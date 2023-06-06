// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "erc721psi/contracts/ERC721Psi.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract testPsi is ERC721Psi,Ownable {
    uint256 MAX_MINTS = 10000000000000;
    uint256 MAX_SUPPLY = 1000000000000000;

    string public baseURI = "abc.com";

    constructor() ERC721Psi("TestPsi", "tp") {}

    function mint(uint256 quantity) external {
        // _safeMint's second argument now takes in a quantity, not a tokenId. (same as ERC721A)
        require(
            quantity + balanceOf(msg.sender) <= MAX_MINTS,
            "Exceeded the limit"
        );
        require(
            totalSupply() + quantity <= MAX_SUPPLY,
            "Not enough tokens left"
        );
        _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}
