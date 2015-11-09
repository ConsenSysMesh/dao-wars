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
  struct Species { string name; address[] creatures; }
  Species[] public species;

  event NewSpecies(uint id, string name, address first_creature);

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Game() {
    admin = msg.sender;
  }

  function clear() auth(admin) {
    species.length = 0;
    num_species = 0;
  }

  function initialize(uint x, uint y, uint8 _eth_deposits, uint _eth_amount, uint _starting_eth, CreatureBuilder _creature_builder) auth(admin) {
    creature_builder = _creature_builder;

    board = new Board();
    board.set_dimensions(x, y);
    board.set_harvest_amount(100000000000000000);

    eth_deposits = _eth_deposits;
    eth_amount = _eth_amount;
    starting_eth = _starting_eth;
  }

  function set_devcon_map() auth(admin){
    board.replace_square(47, true, 0, 0);
    board.replace_square(49, true, 0, 0);
    board.replace_square(65, true, 0, 0);
    board.replace_square(80, true, 0, 0);
    board.replace_square(121, true, 0, 0);
    board.replace_square(122, true, 0, 0);
    board.replace_square(97, true, 0, 0);
    board.replace_square(69, true, 0, 0);
    board.replace_square(84, true, 0, 0);
    board.replace_square(100, true, 0, 0);
    board.replace_square(115, true, 0, 0);
    board.replace_square(172, true, 0, 0);
    board.replace_square(173, true, 0, 0);
    board.replace_square(174, true, 0, 0);
    board.replace_square(175, true, 0, 0);
    board.replace_square(190, true, 0, 0);
    board.replace_square(203, true, 0, 0);
    board.replace_square(138, true, 0, 0);
  }

  function add_creature(address brain, string species_name) {
    uint eth_cost = (eth_deposits * eth_amount) + starting_eth;

    if (msg.value >= eth_cost) {
      Creature creature = creature_builder.build_creature();
      uint location = _random_empty_location();
      uint species_id = num_species++;
      
      board.add_creature(location, creature);
      this.register_creature(creature);
      NewSpecies(species_id, species_name, creature);
      species.length++;
      species[species_id].name = species_name;
      species[species_id].creatures.push(creature);

      creature.set_eth(starting_eth);
      creature.set_brain(brain);
      creature.set_location(location);
      creature.set_hp(3);
      creature.set_board(board);
      creature.set_species(species_id);
      creature.set_creature_builder(creature_builder);
      creature.set_game(this);
      creature.set_admin(admin);

      creature.send(starting_eth);
      board.send(msg.value - starting_eth);
      board.deposit_eth(eth_deposits, eth_amount);  
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
