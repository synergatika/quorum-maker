var colors = require('colors');
const Storage = artifacts.require("Storage");

console.log(colors.cyan('Truffle tests are about to begin...\n'));

contract("Storage", function (accounts) {
  var fromAcc = accounts[0];

const nodes = {
  node1: {
    url: 'ipaddr1',
publicKey: 'brFVrfvImyelz2sJ3g+9/nFMKTz3TcPO7+7Spr6W2Bg='
  },
  node2: {
    url: 'ipaddr2',
publicKey: 'ENsFRd6wC+gvBVr7RSBM0DtyncfKvsOdmuDlwinQ9ws='
  },
  node3: {
    url: 'ipaddr3',
publicKey: 'aSvbLS4OZkXyEyJtKurBwpPU3K+0E9JVY2itiwPUATg='
  }
};

const setProvider = function (instance, url) {
  const newProvider = new web3.providers.HttpProvider(url);
  web3.setProvider(newProvider);
  instance.contract._eth._requestManager.provider = newProvider;
};

it("should assert true", function (done) {
    var storage = Storage.deployed();
    assert.isTrue(true);
    done();
console.log(colors.blue('Contracts have been deployed successfully!\n'));
})


it("should set value from node 1 & get from node 2", function (done) {
    Storage.deployed()
        .then(function (instance) {
            storage = instance;
            return instance.set("50", {
          from: fromAcc,
          privateFor: [nodes.node2.publicKey]
        });
    return instance.get();
 }).then(function (result) {
console.log(colors.white('Value 50 has been set!\n'));
 console.log(colors.yellow('Private transaction hash result of value being set is ')+ result.tx);
 storage.get().then(function(result){
    console.log(colors.yellow('Private value being retrieved is ') + result);
    done();
}).catch(done);

});
});

it("should set value from node 1 & get from node 2", function (done) {
    Storage.deployed()
        .then(function (instance) {
            storage = instance;
            return instance.set("50", {
          from: fromAcc,
          privateFor: [nodes.node2.publicKey]
        });
    return instance.get();
 }).then(function (result) {
console.log(colors.white('Value 50 has been set!\n'));
 console.log(colors.yellow('Private transaction hash result of value being set is ')+ result.tx);
 storage.get().then(function(result){
    console.log(colors.yellow('Private value being retrieved is ') + result);
    done();
}).catch(done);

});
});
});
