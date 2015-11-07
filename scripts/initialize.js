game = Game.deployed();
game.initialize(10,10,5, 1000000000000000000, 500000000000000000000, CreatureBuilder.address).
  then(function() { return game.add_creature(BrainMock.address, "test_species", {value: 1000000000000000000000}) }).
  then(function() { process.exit(); });
