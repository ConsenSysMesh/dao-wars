contract Square {
  uint public gas;
  uint public harvest_amount;
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

  function set_harvest_amount(uint _harvest_amount) auth(admin) {
    harvest_amount = _harvest_amount;
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

  function report_death(uint gas_drop) {
    gas += gas_drop;
    creature = 0;
  }

  function spawn(address _creature) {
    creature = _creature;
  }

  function harvest() auth(creature) returns(uint harvested_amount) {
    if (gas > harvest_amount) {
      gas -= harvest_amount;
      return(harvest_amount);
    } else {
      uint amount = gas;
      gas = 0;
      return(amount);
    }
  }
}
