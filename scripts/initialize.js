game = Game.deployed();
game.initialize(15, 15, 5, 500000000000000000, 1000000000000000000, CreatureBuilder.address).
  then(function() { game.set_devcon_map() }).
  then(function() { process.exit(); });
