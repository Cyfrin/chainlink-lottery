const randomness = artifacts.require("Randomness");
const governance = artifacts.require("Governance");

module.exports = async function(deployer, network, accounts) {
  // const userAddress = accounts[3];
  var governanceContract = await governance.deployed();
  await deployer.deploy(randomness, governanceContract.address);
};
