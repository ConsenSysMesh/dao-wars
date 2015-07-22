contract('Creature', function(accounts) {

  it("should let the brain move it", function(done) {
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
      }).
      then(square_1.creature.call).
      then(function(result) {
        assert.equal(result, 0);
        done();
      }).
      catch(done)
  });

  it("should let the brain harvest gas", function(done) {
    square = Square.at(Square.deployed_address);
    creature = Creature.at(Creature.deployed_address);

    square.set_gas(15000).
      then(function() { return square.set_creature(creature.address) }).
      then(function() { return creature.set_square(square.address) }).
      then(creature.harvest).
      then(creature.gas.call).
      then(function(result) { assert.equal(result, 10000) }).
      then(square.gas.call).
      then(function(result) { assert.equal(result, 5000) }).

      then(creature.harvest).
      then(creature.gas.call).
      then(function(result) { assert.equal(result, 15000) }).
      then(square.gas.call).
      then(function(result) {
        assert.equal(result, 0);
        done()
    }).catch(done)
  });

  it("should let the brain attack neighbors", function(done) {
    square_1 = Square.at(Square.deployed_address);
    creature_1 = Creature.at(Creature.deployed_address);

    Square.new().
      then(function(new_square) { square_2 = new_square }).
      then(Creature.new).
      then(function(new_creature) { creature_2 = new_creature }).
      then(function() { return creature_2.set_hp(3) }).
      then(function() { return creature_1.set_square(square_1.address) }).
      then(function() { return creature_2.set_square(square_2.address) }).
      then(function() { return square_1.set_creature(creature_1.address) }).
      then(function() { return square_2.set_creature(creature_2.address) }).
      then(function() { return square_1.set_neighbors(square_2.address, 0, 0, 0) }).

      then(function() { return creature_1.attack(0) }).
      then(function() { return creature_2.hp.call() }).
      then(function(result) {
        assert.equal(result, 2);
        done()
    }).catch(done)
  });

  it("should die if brought to 0 hp", function(done) {
    square_1 = Square.at(Square.deployed_address);
    creature_1 = Creature.at(Creature.deployed_address);

    Square.new().
      then(function(new_square) { square_2 = new_square }).
      then(Creature.new).
      then(function(new_creature) { creature_2 = new_creature }).
      then(function() { return creature_2.set_hp(1) }).
      then(function() { return creature_2.set_gas(1000) }).
      then(function() { return creature_1.set_square(square_1.address) }).
      then(function() { return creature_2.set_square(square_2.address) }).
      then(function() { return square_1.set_creature(creature_1.address) }).
      then(function() { return square_2.set_creature(creature_2.address) }).
      then(function() { return square_1.set_neighbors(square_2.address, 0, 0, 0) }).

      then(function() { return creature_1.attack(0) }).
      then(function() { return creature_2.dead.call() }).
      then(function(result) { assert.equal(result, true) }).
      then(function() { return square_2.gas.call() }).
      then(function(result) { assert.equal(result, 1000) }).
      then(function() { return square_2.creature.call() }).
      then(function(result) {
        assert.equal(result, 0);
        done()
    }).catch(done)
  });

  it("should allow the brain to reproduce", function(done) {
    square_1 = Square.at(Square.deployed_address);
    creature_1 = Creature.at(Creature.deployed_address);

    Square.new().
    then(function(new_square) { square_2 = new_square }).
    then(function() { return creature_1.set_square(square_1.address) }).
    then(function() { return creature_1.set_species(1) }).
    then(function() { return creature_1.set_creature_builder(CreatureBuilder.deployed_address) }).
    then(function() { return square_1.set_creature(creature_1.address) }).
    then(function() { return square_1.set_neighbors(square_2.address, 0, 0, 0) }).
    then(function() { return creature_1.reproduce(0, accounts[0], 0) }).
    then(function() { return square_2.creature.call() }).
    then(function(result) { creature_2 = Creature.at(result) }).
    then(function() { return creature_2.validate.call() }).
    then(function(result) { assert.equal(result, 42) }).
    then(function() { return creature_2.species.call() }).
    then(function(result) {
      assert.equal(result, 1);
      done();
    }).catch(done)
  })

})
