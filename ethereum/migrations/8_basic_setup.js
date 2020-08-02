const randomness = artifacts.require("Randomness");
const lottery = artifacts.require("Lottery");
const governance = artifacts.require("Governance");

module.exports = async function(deployer, network, accounts) {
  var governanceContract = await governance.deployed();
  var lotteryContract = await lottery.deployed();
  var randomnessContract = await randomness.deployed();

  await lotteryContract.start_new_lottery();
};
