mineAtLeast = function(n) {
  miner.start();
  admin.sleepBlocks(n);
  miner.stop();
  return true;
}

boilerplate = {from: eth.coinbase, gas: 3141592, gasPrice: 1000000000000}
