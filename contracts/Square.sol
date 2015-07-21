contract Square {
  uint public gas;
  Square[4] public neighbors;
  address public admin;
  address public creature;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Square() {
    admin = msg.sender;
  }

  function validate() returns (uint result) {
    uint _result = 42;
    return _result;
  }

  function set_gas(uint _gas) auth(admin) {
    gas = _gas;
  }

  function set_creature(address _creature) auth(admin) {
    creature = _creature;
  }

  function set_neighbors(Square _0, Square _1, Square _2, Square _3) auth(admin) {
    neighbors[0] = _0;
    neighbors[1] = _1;
    neighbors[2] = _2;
    neighbors[3] = _3;
  }

  function leave() auth(creature) {
    creature = 0;
  }

  function enter() {
    creature = msg.sender;
  }
}
