Compiling ./contracts/Migrations.sol...
Compiling ./contracts/Storage.sol...

Compilation warnings encountered:

/home/dev/Quorum-Maker-Development/smart-contracts/contracts/Migrations.sol:11:3: Warning: Defining constructors as functions with the same name as the contract is deprecated. Use "constructor(...) { ... }" instead.
  function Migrations() public {
  ^ (Relevant source part starts here and spans across multiple lines).
,/home/dev/Quorum-Maker-Development/smart-contracts/contracts/Storage.sol:6:1: Warning: No visibility specified. Defaulting to "public". 
function set(uint256 data) {
^ (Relevant source part starts here and spans across multiple lines).
,/home/dev/Quorum-Maker-Development/smart-contracts/contracts/Storage.sol:10:1: Warning: No visibility specified. Defaulting to "public". 
function get() constant returns (uint256) {
^ (Relevant source part starts here and spans across multiple lines).

Writing artifacts to ./build/contracts

Using network 'development'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0xf72d401751364750423c3a694e2c8362c20e4cf20fb838635107cd9c5917be98
  Migrations: 0x1e2d1be473c0c112da6f69a4936b2df133e5d6c7
Saving successful migration to network...
  ... 0xff962088068bda1dd8ec8e108078eb361d90d9c1bfc331c1bbfd8b0a211ed5db
Saving artifacts...
Running migration: 2_deploy_contracts_data.js
  Deploying Storage...
  ... 0x011fcb7c063e567aebe941632db7d45c2486834de8b66ead768e98aa4a275996
  Storage: 0xc191b6313765086e1c6b25009eedf4b430197288
Saving successful migration to network...
  ... 0x096615d2840ed3fcf9faeabbdcfddd152b45219acf477faeb0befc9ab4e274f5
Saving artifacts...
