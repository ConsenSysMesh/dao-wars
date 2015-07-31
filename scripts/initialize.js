// Instructions:
// truffle deploy -e staging
// ./prepare.sh
// geth attach
// loadScript('initialize.js')

loadScript('contracts.js')
boilerplate = {from: "0xa1f4e5914033106a0f8bb4c2446c6cd050bec771", gas: 2000000}

board = eth.contract(contracts.Board.abi).at(contracts.Board.address)
gm = eth.contract(contracts.Gamemaster.abi).at(contracts.Gamemaster.address)
creature = eth.contract(contracts.Creature.abi).at(contracts.Creature.address)
brain = eth.contract(contracts.BrainMock.abi).at(contracts.BrainMock.address)

miner.start()
board.set_gamemaster(gm.address, boilerplate)
gm.set_board(board.address, boilerplate)
creature.set_board(board.address, boilerplate)
creature.set_gamemaster(gm.address, boilerplate)
creature.set_brain(brain.address, boilerplate)
creature.set_gas(100000, boilerplate)
board.set_dimensions(10, 10, boilerplate)
board.spawn(20, creature.address, boilerplate)
board.deposit_gas(30, 100000, boilerplate)
admin.sleepBlocks(1)
