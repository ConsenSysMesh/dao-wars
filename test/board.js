contract('Board', function(accounts) {
  // Not a real test. Feel free to run it if you want to eyeball the board, though.
  xit("can randomly add gas", function(done) {
    board = Board.at(Board.deployed_address);

    board.set_dimensions(3, 3).
    then(function() { return board.deposit_gas(10, 10000) }).
    then(function() {
      complete = 0
      for (i = 0; i < 9; i++) {
        board.squares.call(i).
          then(function(result) {
          console.log(result[1]);
          complete++;
          if (complete == 9) { done() }
        }).catch(done)
      }
    }).catch(done)
  });
});
