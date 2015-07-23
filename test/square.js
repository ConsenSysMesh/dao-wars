contract('Square', function(accounts) {

  it("should let you set gas", function(done) {
    square = Square.at(Square.deployed_address);
    square.set_gas(42).
      then(square.gas.call).
      then(function(result) {
        assert.equal(result, 42);
        done();
    }).catch(done)
  })

  it("should let you set neighbors", function(done) {
    square = Square.at(Square.deployed_address);
    square.set_neighbors(0, Square.deployed_address, 0, 0).
      then(function() { return square.neighbors.call(1) }).
      then(function(result) {
        assert.equal(result, Square.deployed_address);
        done();
    }).catch(done)
  })

  it("should limit changes to original creator", function(done) {
    square = Square.at(Square.deployed_address);
    square.set_gas(42).
      then(function() {
        return square.set_gas(43, {from: accounts[1]});
      }).
      then(square.gas.call).
      then(function(result) {
        assert.equal(result, 42);
        done();
    }).catch(done)
  })

  it("should allow harvest amount to be configured", function(done) {
    square = Square.at(Square.deployed_address);
    creature = Creature.at(Creature.deployed_address);
    square.set_gas(20000).
    then(function() { return square.set_harvest_amount(8000) }).
    then(function() { return square.set_creature(creature.address) }).
    then(function() { return creature.set_gamemaster(accounts[0]); }).
    then(function() { return creature.notify_of_turn() }).
    then(function() { return creature.set_square(square.address) }).
    then(function() { return creature.set_gas(0) }).
    then(function() { return creature.set_brain(accounts[0]) }).

    then(function() { return square.harvest_amount.call() }).
    then(function(result) { assert.equal(result, 8000) }).
    then(function() { return creature.harvest() }).
    then(function() { return creature.gas.call() }).
    then(function(result) {
      assert.equal(result, 8000);
      done();
    }).
      catch(done)
  })

})
