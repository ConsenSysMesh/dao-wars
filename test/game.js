contract('Game', function(accounts) {
  it("generates a board", function(done) {
    var game = Game.at(Game.deployed_address)

    game.initialize(10,10).
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

    game.initialize(10,10).
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
})
