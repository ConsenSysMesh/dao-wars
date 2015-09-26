contract Board {
  bool[] public obstacles;
  uint[] public gas;
  address[] public creatures;
  uint[2] public dimensions;
  uint public harvest_amount;
  bool public in_loop;
  address public admin;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  modifier active_creature_only { 
    /* if (gamemaster.current_creature() == msg.sender) _  */
    _
  }

  function Board() {
    admin = msg.sender;
  }

  function num_squares() returns(uint) {
    return creatures.length;
  }

  function all_gas() returns(uint[]) {
    return gas;
  }

  function all_creatures() returns(address[]) {
    return creatures;
  }

  function all_obstacles() returns(bool[]) {
    return obstacles;
  }

  function set_admin(address _admin) auth(admin) {
    admin = _admin;
  }

  function set_dimensions(uint x, uint y) auth(admin) {
    dimensions[0] = x;
    dimensions[1] = y;
    gas.length = x * y;
    creatures.length = x * y;
    obstacles.length = x * y;
  }

  function set_harvest_amount(uint _harvest_amount) auth(admin) {
    harvest_amount = _harvest_amount;
  }

  function replace_square(uint location, bool obstacle, uint _gas, address creature) auth(admin) {
    obstacles[location] = obstacle;
    gas[location] = _gas;
    creatures[location] = creature;
  }

  function deposit_gas(uint8 num_deposits, uint amount_per_deposit) auth(admin) {
    // Max num_deposits is 32. Does not produce an even distribution. Will come back to.
    uint randomness = uint(block.blockhash(block.number - 1));
    for (uint8 i = 0; i < num_deposits; i++) {
      uint random_num = randomness % 255;
      randomness = randomness / (2**8);
      uint location = (random_num * gas.length) / 255;
      gas[location] += amount_per_deposit;
    }
  }

  function add_creature(uint location, address creature) {
    creatures[location] = creature;
  }

  function leave_square(uint location) active_creature_only {
    creatures[location] = 0;
  }

  function enter_square(uint location) active_creature_only {
    creatures[location] = msg.sender;
  }

  function harvest(uint location) active_creature_only returns (uint result) {
    if (gas[location] > harvest_amount) {
      gas[location] -= harvest_amount;
      return(harvest_amount);
    } else {
      result = gas[location];
      gas[location] = 0;
      return result;
    }
  }

  function spawn(uint location, address creature) {
    /* if (msg.sender == admin || gamemaster.current_creature() == msg.sender) { */
      creatures[location] = creature;
    /* } */
  }

  function report_death(uint location, uint _gas) {
    if (creatures[location] == msg.sender) {
      creatures[location] = 0;
      gas[location] += _gas;
    }
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
