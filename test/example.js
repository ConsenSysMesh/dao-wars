contract('Example', function(accounts) {

  it("should multiply by 2", function(done) {
    example = Example.at(Example.deployed_address);
    example.mul2.call(42).then(function(result) {
      assert.equal(result, 84);
      done();
    }).catch(done)
  })
})
