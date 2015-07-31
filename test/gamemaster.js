contract('Gamemaster', function(accounts) {
  it("allows board to add creatures", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);

    gamemaster.set_board(accounts[0]).
    then(function() { return gamemaster.add_creature(accounts[0]) }).
    then(function() { return gamemaster.add_creature(accounts[0]) }).
    then(function() { return gamemaster.num_creatures.call() }).
    then(function(result) { assert.equal(result, 2) }).
    then(function() { return gamemaster.creatures.call(1) }).
    then(function(result) {
      assert.equal(result, accounts[0]);
      done();
    }).catch(done)
  });

  it("can run a turn that calls the creatures", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);
    brain = BrainMock.at(BrainMock.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    creature.set_brain(brain.address).
    then(function() { return creature.set_gamemaster(gamemaster.address) }).
    then(function() { return creature.set_gas(1000000) }).
    then(function() { return gamemaster.add_creature(creature.address) }).
    then(function() { return gamemaster.run_turn() }).
    then(function() { return brain.times_called.call() }).
    then(function(result) {
      assert.equal(result, 1);
      done();
    }).catch(done)
  });

  it("deducts gas from the creature", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);
    brain = BrainMock.at(BrainMock.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    creature.set_brain(brain.address).
    then(function() { return creature.set_gamemaster(gamemaster.address) }).
    then(function() { return creature.set_gas(100000) }).
    then(function() { return gamemaster.add_creature(creature.address) }).
    then(function() { return gamemaster.run_turn() }).
    then(function() { return creature.gas.call() }).
    then(function(result) {
      assert.notEqual(result, 100000);
      done();
    }).catch(done)
  });

  it("doesn't let creatures exceed gas limit", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);
    brain = BrainMock.at(BrainMock.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    creature.set_brain(brain.address).
    then(function() { return creature.set_gamemaster(gamemaster.address) }).
    then(function() { return creature.set_gas(1000) }).
    then(function() { return gamemaster.add_creature(creature.address) }).
    then(function() { return brain.reset() }).
    then(function() { return gamemaster.run_turn() }).
    then(function() { return creature.gas.call() }).
    then(function(result) { assert.equal(result, 0) }).
    then(function() { return creature.dead.call() }).
    then(function(result) { assert.equal(result, true) }).
    then(function() { return brain.times_called.call() }).
    then(function(result) {
      assert.equal(result, 0);
      done();
    }).catch(done)
  });
})
