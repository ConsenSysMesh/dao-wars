contract Gamemaster {
  address[] public creatures;
  address[] public squares;
  uint[2] public dimensions;
  address public admin;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Gamemaster() {
    admin = msg.sender;
  }

  function set_admin(address _admin) auth(admin) {
    admin = _admin;
  }

  function set_creatures(address[] _creatures) auth(admin) {
    creatures = _creatures;
  }

  function add_creature(address _new_creature) auth(admin) {
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

  function set_squares(address[] _squares) auth(admin) {
    squares = _squares;
  }
}
