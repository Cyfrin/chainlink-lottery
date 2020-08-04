# chainlink-lottery

You can play with this in [remix here](https://remix.ethereum.org/#version=soljson-v0.6.6+commit.6c089d02.js&optimize=false&gist=b3939b346828763673a188007e8f487c)

A web3 implementation of a decentralized provably random lottery using Chainlink VRF and Chainlink alarm clock to have a totally decentralized lottery. Check the ETH readme for how to do the truffle stuff. 

# To run:

```
git clone <this_repo>
cd chainlink-lottery
npm install --save solc@0.6.6
npm install
```

Make sure you have `RPC_URL` and `MNEMONIC` in your environment variables

# To set this up from scratch, you can run:
Setup:

```
npx create-react-app chainlink-lottery
cd chainlink-lottery
mkdir ethereum
cd ethereum
truffle unbox smartcontractkit/box
```

# Mirgrate

`truffle migrate --network live`

# TODO

- [ ] Fix all the permission issues (random people can break the lottery at the moment, should be an easy fix)
- [ ] Add more VRF nodes to decentralize the random number part
- [ ] Add more Alarm clocks to decentralize the alarm clock part
- [ ] Write tests
- [ ] write scripts to make stuff easier
- [ ] Cool frontend
