initializer.create_game.sendTransaction(1, 0, 0, 10, 40000, 100000, {from: eth.coinbase, gas: 3141592, gasPrice: 1000000000000});

mineAtLeast(1);

phase = 0;
i = 0
miner.start();
while (phase != 2) {
  initializer.take_single_action.sendTransaction(1, {from: eth.coinbase, gas: 3141592, gasPrice: 1000000000000});
  phase = initializer.get_game_phase.call(1, {from: eth.coinbase});
  i++
  console.log(i)
  console.log(phase)
}
miner.stop();

gamemaster = initializer.get_gamemaster.call(1, {from: eth.coinbase});
