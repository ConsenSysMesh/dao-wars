import "Board";
import "CreatureBuilder";

contract Game {
  Board public board;
  CreatureBuilder public creature_builder;
  address public admin;
  uint8 public eth_deposits;
  uint public eth_amount;
  uint public starting_eth;
  uint public num_species;
  mapping (address => bool) public valid_creature;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Game() {
    admin = msg.sender;
  }

  function initialize(uint x, uint y, uint8 _eth_deposits, uint _eth_amount, uint _starting_eth, CreatureBuilder _creature_builder) auth(admin) {
    creature_builder = _creature_builder;

    board = new Board();
    board.set_dimensions(x, y);

    eth_deposits = _eth_deposits;
    eth_amount = _eth_amount;
    starting_eth = _starting_eth;
  }

  function add_creature(address brain) {
    num_species++;
    Creature creature = creature_builder.build_creature();
    uint location = _random_empty_location();
    
    board.add_creature(location, creature);

    this.register_creature(creature);

    creature.set_location(location);
    creature.set_hp(3);
    creature.set_board(board);
    creature.set_species(num_species);
    creature.set_creature_builder(creature_builder);
    creature.set_game(this);
    creature.set_admin(admin);

    board.deposit_eth(eth_deposits, eth_amount);  
  }

  function register_creature(address _creature) {
    if (msg.sender == address(this) || msg.sender == admin || valid_creature[msg.sender] == true) {
      valid_creature[_creature] = true;
    }
  }

  function _random_empty_location() returns(uint) {
    uint randomness = uint(block.blockhash(block.number - 1));
    uint num_squares = board.num_squares();

    uint random_num = randomness % num_squares;

    for (uint i = 0; i < num_squares; i++) {
      uint location = random_num + i;

      if (board.obstacles(location) == false && board.creatures(location) == 0) {
        return location;
      }
    }
  }
}
