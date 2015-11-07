import "Board";
import "CreatureBuilder";

contract Game {
  Board public board;
  CreatureBuilder public creature_builder;
  address public admin;
  uint8 public gas_deposits;
  uint public gas_amount;
  uint public starting_gas;
  uint public num_species;
  mapping (address => bool) public valid_creature;
  struct Species { string name; address[] creatures; }
  Species[] public species;

  event NewSpecies(uint id, string name, address first_creature);

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Game() {
    admin = msg.sender;
  }

  function initialize(uint x, uint y, uint8 _gas_deposits, uint _gas_amount, uint _starting_gas, CreatureBuilder _creature_builder) auth(admin) {
    creature_builder = _creature_builder;

    board = new Board();
    board.set_dimensions(x, y);

    gas_deposits = _gas_deposits;
    gas_amount = _gas_amount;
    starting_gas = _starting_gas;
  }

  function add_creature(address brain, string species_name) {
    uint gas_cost = (gas_deposits * gas_amount) + starting_gas;

    if (msg.value >= gas_cost) {
      Creature creature = creature_builder.build_creature();
      uint location = _random_empty_location();
      uint species_id = num_species++;
      
      board.add_creature(location, creature);
      this.register_creature(creature);
      NewSpecies(species_id, species_name, creature);
      species.length++;
      species[species_id].name = species_name;
      species[species_id].creatures.push(creature);

      creature.set_gas(starting_gas);
      creature.set_brain(brain);
      creature.set_location(location);
      creature.set_hp(3);
      creature.set_board(board);
      creature.set_species(species_id);
      creature.set_creature_builder(creature_builder);
      creature.set_game(this);
      creature.set_admin(admin);

      creature.send(starting_gas);
      board.send(msg.value - starting_gas);
      board.deposit_gas(gas_deposits, gas_amount);  
    }
  }

  function all_creatures_for_species(uint id) returns(address[]) {
    return species[id].creatures;
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
