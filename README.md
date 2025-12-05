# MyToken (MTK)

## Overview
MyToken is a simple ERC-20 compatible token built on Ethereum for learning purposes.

## Token Details
- **Name**: MyToken
- **Symbol**: MTK
- **Decimals**: 18
- **Total Supply**: 1,000,000 MTK

## Features
- ✅ Standard ERC-20 implementation
- ✅ Transfer tokens between addresses
- ✅ Approve and transferFrom functionality
- ✅ Event emission for transparency
- ✅ Balance tracking

## How to Deploy
1. Open RemixIDE
2. Create new file `MyToken.sol`
3. Paste the contract code
4. Compile with Solidity 0.8.x
5. Deploy with desired total supply

## How to Use
### Check Balance
balanceOf(address user) → returns uint256
This function returns the token balance of any address.

Transfer Tokens transfer(address to, uint256 amount) → returns bool
Used to send tokens from your address to another.

Approve Spending approve(address spender, uint256 amount) → returns bool
Allows another address to spend tokens on your behalf.

Transfer on Behalf transferFrom(address from, address to, uint256 amount) → returns bool
Used by the approved spender to perform delegated transfers.
