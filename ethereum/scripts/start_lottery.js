const lottery = artifacts.require("Lottery");
const duration = 90;

module.exports = async (callback) => {
  const mc = await Lottery.deployed();
  console.log("Starting new lottery:", lottery.address);
  const tx = await lottery.start_new_lottery(duration).send();
  callback(tx.tx);
};
