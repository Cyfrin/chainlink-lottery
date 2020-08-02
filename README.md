# chainlink-lottery

A web3 implementation of a lottery using Chainlink VRF and Chainlink alarm clock to have a totally decentralized lottery

Setup:

```
npx create-react-app chainlink-lottery
cd chainlink-lottery
mkdir ethereum
cd ethereum
truffle unbox smartcontractkit/box
```

Then we did some [fancy stuff to get the Truffle to work with github](https://solidity.readthedocs.io/en/develop/layout-of-source-files.html?highlight=import#use-in-actual-compilers)

```
npm install --save solc@0.6.6
brew install https://raw.githubusercontent.com/ethereum/homebrew-ethereum/de827603ab5095abbe4edce3ef282e783fc352a2/solidity.rb
solc github.com/smartcontractkit/chainlink/=/usr/local/chainlink/ Lottery.sol
```

# To run:

```
git clone <this_repo>
cd chainlink-lottery
npm install
```

Make sure you have `RPC_URL` and `MNEMONIC` in your environment variables

# Mirgrate

`truffle migreate --network live`
