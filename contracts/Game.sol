import "Board";
import "Gamemaster";
import "CreatureBuilder";

contract Game {
  Board public board;
  Gamemaster public gamemaster;
  CreatureBuilder public creature_builder;
  address public admin;
  uint8 public gas_deposits;
  uint public gas_amount;
  uint public starting_gas;
  uint public num_species;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Game() {
    admin = msg.sender;
  }

  function initialize(uint x, uint y, uint8 _gas_deposits, uint _gas_amount, uint _starting_gas, CreatureBuilder _creature_builder) auth(admin) {
    creature_builder = _creature_builder;

    board = new Board();
    board.set_dimensions(x, y);

    gamemaster = new Gamemaster();
    gamemaster.set_board(board);
    board.set_gamemaster(gamemaster);

    gas_deposits = _gas_deposits;
    gas_amount = _gas_amount;
    starting_gas = _starting_gas;
  }

  function run_turn() auth(admin) {
    gamemaster.run_turn();
  }

  function add_creature(address brain) {
    num_species++;
    Creature creature = creature_builder.build_creature();
    uint location = _random_empty_location();
    
    board.add_creature(location, creature);

    creature.set_location(location);
    creature.set_hp(3);
    creature.set_board(board);
    creature.set_species(num_species);
    creature.set_creature_builder(creature_builder);
    creature.set_admin(admin);

    gamemaster.add_creature(creature);
    board.deposit_gas(gas_deposits, gas_amount);  
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
