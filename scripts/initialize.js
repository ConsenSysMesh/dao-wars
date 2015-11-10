game = Game.deployed();
game.initialize(15, 15, 4, 500000000000000000, 1000000000000000000, CreatureBuilder.address, {gasPrice: 100000000000}).
  then(function() { game.set_devcon_map({gasPrice: 100000000000}) }).
  then(function() { process.exit(); });
