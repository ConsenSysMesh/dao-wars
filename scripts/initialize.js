game = Game.deployed();
game.initialize(10,10,5, 1000000000000000000, 500000000000000000000, CreatureBuilder.address).
  then(function() { return game.add_creature(BrainMock.address, {value: 1000000000000000000000}) }).
  then(function() { return game.board.call() }).
  then(function(result) {
    board = Board.at(result);
    return board.all_creatures.call().
      then(function(result) { console.log(result) });
  }).
  then(function() { process.exit(); });
