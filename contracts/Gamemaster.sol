contract Gamemaster {
  address[] public creatures;

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
}
