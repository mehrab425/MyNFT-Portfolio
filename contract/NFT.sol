// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC721Enumerable, Ownable, ReentrancyGuard {
    using Strings for uint256;

    string public baseTokenURI;
    string public baseExtension = ".json";
    uint256 public cost = 0.5 ether;
    uint256 public maxSupply = 20;
    bool public mintActive = true;

    constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI
) ERC721(_name, _symbol) Ownable(msg.sender) {
    baseTokenURI = _initBaseURI;
    _mintLoop(msg.sender, 3);
}


    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require(_ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
}



    function mint(address _to, uint256 _mintAmount) public payable {
        uint256 supply = totalSupply();
        require(mintActive, "Minting is paused");
        require(_mintAmount > 0, "Need to mint at least 1 NFT");
        require(supply + _mintAmount <= maxSupply, "Exceeds max supply");
        require(msg.value >= cost * _mintAmount, "Insufficient ETH");

        _mintLoop(_to, _mintAmount);
    }

    function _mintLoop(address _to, uint256 _mintAmount) internal {
        uint256 supply = totalSupply();
        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(_to, supply + i);
        }
    }

    function walletOfOwner(address _owner) public view returns (uint256[] memory) {
        uint256 ownerCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerCount);
        for (uint256 i = 0; i < ownerCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseTokenURI = _newBaseURI;
    }

    function setCost(uint256 _newCost) public onlyOwner {
        cost = _newCost;
    }

    function setBaseExtension(string memory _newBaseExtension) external onlyOwner {
        baseExtension = _newBaseExtension;
    }

    function toggleMintActive() external onlyOwner {
        mintActive = !mintActive;
    }

    function withdraw() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");

        (bool sent, ) = payable(owner()).call{value: balance}("");
        require(sent, "Withdraw failed");
    }
}
