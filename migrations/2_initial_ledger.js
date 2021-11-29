const Ledger = artifacts.require("Ledger");

module.exports = function (deployer) {
  deployer.deploy(Ledger);
};
