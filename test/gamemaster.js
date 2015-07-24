contract('Gamemaster', function(accounts) {
  it("allows creatures to be set as list", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);

    gamemaster.set_creatures([accounts[1], accounts[0]]).
    then(function() { return gamemaster.num_creatures.call() }).
    then(function(result) { assert.equal(result, 2) }).
    then(function() { return gamemaster.creatures.call(1) }).
    then(function(result) {
      assert.equal(result, accounts[0]);
      done();
    }).catch(done)
  });

  it("allows creatures to be added one at a time", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);

    gamemaster.set_creatures([]).
    then(function() { return gamemaster.add_creature(accounts[0]) }).
    then(function() { return gamemaster.add_creature(accounts[1]) }).
    then(function() { return gamemaster.num_creatures.call() }).
    then(function(result) { assert.equal(result, 2) }).
    then(function() { return gamemaster.creatures.call(1) }).
    then(function(result) {
      assert.equal(result, accounts[1]);
      done();
    }).catch(done)
  });

  it("can run a turn that calls the creatures", function(done) {
    gamemaster = Gamemaster.at(Gamemaster.deployed_address);
    brain = BrainMock.at(BrainMock.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    creature.set_brain(brain.address).
    then(function() { return creature.set_gamemaster(gamemaster.address) }).
    then(function() { return gamemaster.add_creature(creature.address) }).
    then(function() { return gamemaster.run_turn() }).
    then(function() { return brain.times_called.call() }).
    then(function(result) {
      assert.equal(result, 1);
      done();
    }).catch(done)
  });
})
