var colors = require('colors');
const Storage = artifacts.require("Storage");

console.log(colors.cyan('Truffle tests are about to begin...\n'));

it("should assert true", function (done) {
    var storage = Storage.deployed();
    assert.isTrue(true);
    done();
console.log(colors.blue('Contracts have been deployed successfully!\n'));
})


it("should set value", function (done) {
    Storage.deployed()
        .then(function (instance) {
            storage = instance;
            return instance.set("50");
 }).then(function (result) {
console.log(colors.white('Value 50 has been set!\n'));
 console.log(colors.yellow('Transaction hash result of value being set is ')+ result.tx);
 storage.get().then(function(result){
    console.log(colors.yellow('Value being retrieved is ') + result);
    done();
}).catch(done);

});
});
