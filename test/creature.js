contract('Creature', function(accounts) {

  it("should let the brain move it", function(done) {
    // var square_2 = {};
    square_1 = Square.at(Square.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    Square.new().
      then(function (new_square) {
        square_2 = new_square;
        return square_1.set_neighbors(square_2.address, 0, 0, 0);
      }).
      then(function() {
        return square_2.set_neighbors(0, square_1.address, 0, 0);
      }).
      then(function() { return creature.set_square(square_1.address); }).
      then(function() { return creature.move(0) }).
      then(creature.square.call).
      then(function(result) {
        assert.equal(result, square_2.address);
      }).
      then(function() { return square_2.creature.call() }).
      then(function(result) {
        assert.equal(result, creature.address);
        done();
      }).
      then(square_1.creature.call).
      then(function(result) {
        assert.equal(result, 0);
      }).
      catch(done)
  })
})
