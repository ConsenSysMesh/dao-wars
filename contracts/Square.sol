contract Square {
  uint public gas;
  address[4] public neighbors;
  address public admin;

  modifier authenticated(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Square() {
    admin = msg.sender;
  }

  function set_gas(uint _gas) authenticated(admin) {
    gas = _gas;
  }

  function set_neighbors(address _0, address _1, address _2, address _3) authenticated(admin) {
    neighbors[0] = _0;
    neighbors[1] = _1;
    neighbors[2] = _2;
    neighbors[3] = _3;
  }
}
