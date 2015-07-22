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

})
