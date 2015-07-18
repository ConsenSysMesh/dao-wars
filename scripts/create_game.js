board.set_dimensions(3,3, boilerplate);
board.set_gas_amount(40000, boilerplate);
mineAtLeast(2);

phase = 0;
i = 0
miner.start();
while (phase != 3) {
  transaction = board.take_single_action.sendTransaction(boilerplate);

  admin.sleepBlocks(1)

  phase = board.take_single_action.call();

  console.log(i)
  console.log(phase)
  i++
}
miner.stop();
