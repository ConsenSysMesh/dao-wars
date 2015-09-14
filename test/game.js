contract('Game', function(accounts) {
  it("generates a board", function(done) {
    var game = Game.at(Game.deployed_address)

    game.initialize(10,10, 30, 500000).
      then(function() { return game.board.call() }).
      then(function(result) {
        assert.notEqual(result, 0);
        var board = Board.at(result);

        board.dimensions.call(0).
        then(function(result) { assert.equal(result, 10) }).
        then(function() { return board.dimensions.call(1) }).
        then(function(result) {
          assert.equal(result, 10);
          done();
        }).catch(done)
      }).catch(done)
  })

  it("generates a gamemaster", function(done) {
    var game = Game.at(Game.deployed_address)

    game.initialize(10,10, 30, 200000).
      then(function() { return game.gamemaster.call() }).
      then(function(result) {
        assert.notEqual(result, 0);
        var gamemaster = Gamemaster.at(result);

        gamemaster.board.call().
        then(function(result) {
          assert.notEqual(result, 0);
          done();
        }).catch(done)
    }).catch(done)
  })

  it("allows creatures to be added", function(done) {
    var game = Game.at(Game.deployed_address)

    game.initialize(1, 1, 3, 20000).
      then(function() { return game.board.call() }).
      then(function(result) {
        var board = Board.at(result);

        game.add_creature(Creature.deployed_address).
        then(function() { return board.creatures.call(0) }).
        then(function(result) {
          assert.equal(result, Creature.deployed_address);
        }).
        then(function() { return board.gas.call(0) }).
        then(function(result) {
          assert.equal(result, 60000);
          done();
        }).catch(done)
    }).catch(done)
  })
})
