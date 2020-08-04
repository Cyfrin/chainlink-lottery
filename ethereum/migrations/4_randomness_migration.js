const Randomness = artifacts.require("Randomness");
const Governance = artifacts.require("Governance");

module.exports = async function (deployer, network, accounts) {
  // const userAddress = accounts[3];
  var governanceContract = await Governance.deployed();
  await deployer.deploy(Randomness, governanceContract.address);
};

