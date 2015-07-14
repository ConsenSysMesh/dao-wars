mineAtLeast = function(n) {
  miner.start();
  admin.sleepBlocks(n);
  miner.stop();
  return true;
}
