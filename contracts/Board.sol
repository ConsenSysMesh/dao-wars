contract Board {
  struct Square { bool obstacle; uint gas; address creature; }
  Square[] public squares;
  uint[2] public dimensions;
  uint public harvest_amount;
  bool public in_loop;

  function set_dimensions(uint x, uint y) {
    dimensions[0] = x;
    dimensions[1] = y;
    squares.length = x * y;
  }

  function set_harvest_amount(uint _harvest_amount) {
    harvest_amount = _harvest_amount;
  }

  function replace_square(uint location, bool obstacle, uint gas, address creature) {
    squares[location] = Square(obstacle, gas, creature);
  }

  function deposit_gas(uint8 num_deposits, uint amount_per_deposit) {
    // Max num_deposits is 32. Does not produce an even distribution. Will come back to.
    uint randomness = uint(block.blockhash(block.number - 1));
    for (uint8 i = 0; i < num_deposits; i++) {
      uint random_num = randomness % 255;
      randomness = randomness / (2**8);
      uint location = (random_num * squares.length) / 255;
      squares[location].gas += amount_per_deposit;
    }
  }

  function creature_at_location(uint location) returns (address result) {
    return squares[location].creature;
  }

  function gas_at_location(uint location) returns (uint result) {
    return squares[location].gas;
  }

  function leave_square(uint location) {
    squares[location].creature = 0;
  }

  function enter_square(uint location) {
    squares[location].creature = msg.sender;
  }

  function harvest(uint location) returns (uint result) {
    if (squares[location].gas > harvest_amount) {
      squares[location].gas -= harvest_amount;
      return(harvest_amount);
    } else {
      result = squares[location].gas;
      squares[location].gas = 0;
      return result;
    }
  }

  function spawn(uint location, address creature) {
    squares[location].creature = creature;
  }

  function report_death(uint location, uint gas) {
    squares[location].creature = 0;
    squares[location].gas += gas;
  }

  function neighbor(uint location, uint8 direction) returns(uint result){
    // The crazy conditions keep it from going off the edge.
    if (direction == 0 && ((location % dimensions[0]) != 0)) {
      return location - 1;
    }
    if (direction == 1 && ((location % dimensions[0]) != (dimensions[0] - 1))) {
      return location + 1;
    }
    if (direction == 2 && (location > dimensions[0])) {
      return location - dimensions[0];
    }
    if (direction == 3 && (location < ((dimensions[0] * dimensions[1] - 1)))) {
      return location + dimensions[0];
    }

    return 0;
  }
}
