contract Board {
  struct Square { bool obstacle; uint gas; address creature; }
  Square[] public squares;
  uint[2] public dimensions;
  uint public generated_up_to;
  uint public starting_gas;
  bool public in_loop;

  function set_dimensions(uint x, uint y) {
    dimensions[0] = x;
    dimensions[1] = y;
    squares.length = x * y;
  }

  function deposit_gas(uint8 num_deposits, uint amount_per_deposit) {
    // Max num_deposits is 32. Does not produce an even distribution. Will come back to.
    uint randomness = uint(block.blockhash(block.number - 1));
    for (uint8 i = 0; i < num_deposits; i++) {
      uint random_num = randomness % 255;
      randomness = randomness / (2**8);
      uint index = (random_num * squares.length) / 255;
      squares[index].gas += amount_per_deposit;
    }
  }

  function coordinates(uint x, uint y) returns (bool obstacle, uint gas, address creature) {
    uint index = x*dimensions[1] + y; // Flattens two-dimensional coordinate to 1-dimensional squares array
    obstacle = squares[index].obstacle;
    gas = squares[index].gas;
    creature = squares[index].creature;
  }
}
