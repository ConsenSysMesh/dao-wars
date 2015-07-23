contract Gamemaster {
  address[] public creatures;
  address[] public squares;
  uint[2] public dimensions;

  function set_creatures(address[] _creatures) {
    creatures = _creatures;
  }

  function add_creature(address _new_creature) {
    uint new_index = creatures.length;
    creatures.length++;
    creatures[new_index] = _new_creature;
  }

  function num_creatures() returns (uint result) {
    return creatures.length;
  }

  function set_dimensions(uint x, uint y) {
    dimensions[0] = x;
    dimensions[1] = y;
  }

  function set_squares(address[] _squares) {
    squares = _squares;
  }
}
