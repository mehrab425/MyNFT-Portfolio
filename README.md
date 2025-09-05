# MyNFT-Portfolio
# MyNFT-Portfolio


# MyNFTgame 🎮 (ERC721 on Holesky)

A minimal ERC721 NFT collection powered by **Solidity 0.8.30**, **OpenZeppelin ERC721**, and **IPFS**.

## 🔗 Deployment
- **Network:** Ethereum Holesky Testnet (chainId: 17000)
- **Contract Address:** `0xD1Da52CC507ce6187164a847eF3e1Cd73Dd4Dbd1`
- **Explorer:** https://holesky.etherscan.io/address/0xD1Da52CC507ce6187164a847eF3e1Cd73Dd4Dbd1

## ✨ Features
- 3 item types (e.g. `SWORD`, `SHIELD`, `HERO`)
- Public mint with price (editable)
- Supply cap per item
- (Optional) Level-up mechanics
- Dynamic metadata URI (IPFS)

## 🧱 Tech Stack
- Solidity ^0.8.30
- OpenZeppelin (ERC1155, Ownable)
- Remix IDE + MetaMask
- IPFS/Pinata for metadata & assets

## 🧪 How to Interact (Remix)
1. Open Remix → **Deploy & Run** → `Injected Provider - MetaMask` (Holesky).
2. Paste contract address under **At Address** to attach.
3. Call `mint(id, amount)` with value (e.g. `0.01 ETH * amount`).
4. Check balances via `balanceOf(account, id)`.

## 📦 ABI
See [`abi/MyNFTgame.json`](./abi/MyNFTgame.json) for dApp integration.

## 🖼️ Metadata
Example metadata lives in [`metadata/`](./metadata).  
Example URI pattern used in contract: `ipfs://YOUR_CID/{id}.json`

## ✅ Verify on Holesky Etherscan
- Go to contract page → **Code** tab → **Verify & Publish**
- Compiler: `v0.8.30` | License: `MIT`
- Paste source (or use multi-file/flatten) with exact compiler settings (optimizer, runs).

## © License
MIT



