
const governanceContract = artifacts.require("Governance");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(governanceContract);
};