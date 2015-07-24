import "Creature";

contract Gamemaster {
  Creature[] public creatures;
  address public board;
  uint[2] public dimensions;
  address public admin;
  Creature public current_creature;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Gamemaster() {
    admin = msg.sender;
  }

  function set_admin(address _admin) auth(admin) {
    admin = _admin;
  }

  function set_creatures(Creature[] _creatures) auth(admin) {
    creatures = _creatures;
  }

  function add_creature(Creature _new_creature) auth(admin) {
    uint new_index = creatures.length;
    creatures.length++;
    creatures[new_index] = _new_creature;
  }

  function num_creatures() returns (uint result) {
    return creatures.length;
  }

  function set_dimensions(uint x, uint y) auth(admin) {
    dimensions[0] = x;
    dimensions[1] = y;
  }

  function set_board(address _board) auth(admin) {
    board = _board;
  }

  function run_turn() {
    for (uint i; i < creatures.length; i++) {
      current_creature = creatures[i];

      current_creature.notify_of_turn();
    }
  }
}
