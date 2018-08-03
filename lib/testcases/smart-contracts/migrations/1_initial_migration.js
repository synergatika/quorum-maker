var colors = require('colors');
var Migrations = artifacts.require("./Migrations.sol");

console.log(colors.red('Preparing truffle...\n'));

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
