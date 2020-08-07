To deploy all the contracts

For some reason the console part doesn't work :/

```
truffle migrate --reset --network=live
```

Then you can run the scripts like:

```
npx truffle exec scripts/fund_contract.js --network live
```

The other two don't work.... but ideally you could run them too.
Or use the truffle console... Which is also not working

```
truffle console --network live
let lottery = await Lottery.deployed()
let randomness = await Randomness.deployed()
// Get the address of lottery and randomness from the above two, and fund them with some LINK
let accounts = await web3.eth.getAccounts()
// a 90 second long lottery
lottery.start_new_lottery(90)
lottery.enter({from: accounts[0], value:1000000000000000})
```

You should see something in the resulting ropsten

To test:
`truffle test`

# Chainlink Truffle Box

Implementation of a [Chainlink requesting contract](https://docs.chain.link/docs/create-a-chainlinked-project).

## Requirements

- NPM

## Installation

Package installation should have occurred for you during the Truffle Box setup. However, if you add dependencies, you'll need to add them to the project by running:

```bash
npm install
```

Or

```bash
yarn install
```

## Test

```bash
npm test
```

## Deploy

If needed, edit the `truffle-config.js` config file to set the desired network to a different port. It assumes any network is running the RPC port on 8545.

```bash
npm run migrate:dev
```

For deploying to live networks, Truffle will use `truffle-hdwallet-provider` for your mnemonic and an RPC URL. Set your environment variables `$RPC_URL` and `$MNEMONIC` before running:

```bash
npm run migrate:live
```

## Helper Scripts

They can be used by calling them from `npx truffle exec`, for example:

```bash
npx truffle exec scripts/fund_contract.js --network live
npx truffle exec scripts/start_lottery.js --network live
npx truffle exec scripts/enter_lottery.js --network live
```
