const Governance = artifacts.require("Governance");
const Randomness = artifacts.require("Randomness");
const Lottery = artifacts.require("Lottery");

module.exports = async function(deployer, network, accounts) {
  var governanceContract = await Governance.deployed();
  var randomnessContract = await Randomness.deployed();
  var lotteryContract = await Lottery.deployed();

  await governanceContract.init(
    lotteryContract.address,
    randomnessContract.address
  );
};
