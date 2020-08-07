const { ethers } = require("ethers");
const fs = require("fs");
const Randomness = artifacts.require("Randomness");
const Lottery = artifacts.require("Lottery");
const payment = process.env.TRUFFLE_CL_BOX_PAYMENT || "2000000000000000000";
let raw = fs.readFileSync("../abis/LinkToken.json");
const ABI = JSON.parse(raw);

module.exports = async function(callback) {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  // Hard coded for ropsten
  const linkAddress = "0x20fE562d797A42Dcb3399062AE9546cd06f63280";
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const linkContract = new ethers.Contract(linkAddress, ABI, wallet);

  var randomnessContract = await Randomness.deployed();
  var lotteryContract = await Lottery.deployed();
  console.log(lotteryContract.address);
  console.log(randomnessContract.address);

  await linkContract
    .transfer(randomnessContract.address, payment)
    .then(function(tx) {
      console.log(tx);
    });

  await linkContract
    .transfer(lotteryContract.address, payment)
    .then(function(tx) {
      console.log(tx);
    });
  callback();
};
