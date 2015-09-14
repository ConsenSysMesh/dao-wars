// Instructions:
// truffle deploy -e staging
// ./prepare.sh
// geth attach
// loadScript('initialize.js')

loadScript('contracts.js')
boilerplate = {from: eth.coinbase, gas: 2000000}

game = eth.contract(contracts.Game.abi).at(contracts.Game.address)

miner.start()
game.initialize(10,10,10,1000000,boilerplate)
admin.sleepBlocks(1)
game.add_creature(contracts.Creature.address,boilerplate)
admin.sleepBlocks(1)

board = eth.contract(contracts.Board.abi).at(game.board())
