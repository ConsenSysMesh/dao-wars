contract CreatureStub {
  function notify_of_turn() {}
}

contract Gamemaster {
  CreatureStub[] public creatures;
  CreatureStub public current_creature;
  address public board;
  address public admin;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Gamemaster() {
    admin = msg.sender;
  }

  function set_admin(address _admin) auth(admin) {
    admin = _admin;
  }

  function add_creature(address _new_creature) auth(board) {
    uint new_index = creatures.length;
    creatures.length++;
    creatures[new_index] = CreatureStub(_new_creature);
  }

  function num_creatures() returns (uint result) {
    return creatures.length;
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
