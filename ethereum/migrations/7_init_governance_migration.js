const governance = artifacts.require("Governance");
const randomness = artifacts.require("Randomness");
const lottery = artifacts.require("Lottery");

module.exports = async function(deployer, network, accounts) {
  var governanceContract = await governance.deployed();
  var randomnessContract = await randomness.deployed();
  var lotteryContract = await lottery.deployed();

  await governanceContract.init(
    lotteryContract.address,
    randomnessContract.address
  );
};
