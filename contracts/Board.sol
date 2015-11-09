contract GameStub {
  function valid_creature(address _creature) returns(bool) {}
}

contract Board {
  bool[] public obstacles;
  uint[] public eth;
  address[] public creatures;
  uint[2] public dimensions;
  uint public harvest_amount;
  bool public in_loop;
  GameStub public game;
  address public admin;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Board() {
    admin = msg.sender;
    game = GameStub(msg.sender);
  }

  function num_squares() returns(uint) {
    return creatures.length;
  }

  function all_eth() returns(uint[]) {
    return eth;
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
    eth.length = x * y;
    creatures.length = x * y;
    obstacles.length = x * y;
  }

  function set_harvest_amount(uint _harvest_amount) auth(admin) {
    harvest_amount = _harvest_amount;
  }

  function set_game(address _game) auth(admin) { 
    game = GameStub(_game);
  }

  function replace_square(uint location, bool obstacle, uint _eth, address creature) auth(admin) {
    obstacles[location] = obstacle;
    eth[location] = _eth;
    creatures[location] = creature;
  }

  function deposit_eth(uint8 num_deposits, uint amount_per_deposit) auth(admin) {
    // Max num_deposits is 32. Does not produce an even distribution. Will come back to.
    uint randomness = uint(block.blockhash(block.number - 1));
    for (uint8 i = 0; i < num_deposits; i++) {
      uint random_num = randomness % 255;
      randomness = randomness / (2**8);
      uint location = (random_num * eth.length) / 255;
      eth[location] += amount_per_deposit;
    }
  }

  function add_creature(uint location, address creature) {
    creatures[location] = creature;
  }

  function leave_square(uint location) {
    if (game.valid_creature(msg.sender) == true) {
      creatures[location] = 0;
    }
  }

  function enter_square(uint location) {
    if (game.valid_creature(msg.sender) == true) {
      creatures[location] = msg.sender;
    }
  }

  function harvest(uint location) returns (uint result) {
    if (game.valid_creature(msg.sender) == true) {
      if (eth[location] > harvest_amount) {
        eth[location] -= harvest_amount;
        msg.sender.send(harvest_amount);
        return(harvest_amount);
      } else {
        result = eth[location];
        eth[location] = 0;
        msg.sender.send(result);
        return result;
      }
    }
  }

  function spawn(uint location, address creature) {
    if (game.valid_creature(msg.sender) == true || msg.sender == admin) {
      creatures[location] = creature;
    }
  }

  function report_death(uint location, uint _eth) {
    if (creatures[location] == msg.sender) {
      creatures[location] = 0;
      eth[location] += _eth;
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
