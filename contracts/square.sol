contract Square {
  address left;
  address right;
  address up;
  address down;
  address inhabitant;
  uint ether;

  function get_down() returns (address _down) {
    _down = down;
  }

  function get_ether() returns (uint _ether) {
    _ether = ether;
  }

  function get_inhabitant() returns (address _inhabitant) {
    _inhabitant = inhabitant;
  }

  function get_left() returns (address _left) {
    _left = left;
  }

  function get_right() returns (address _right) {
    _right = right;
  }

  function get_up() returns (address _up) {
    _up = up;
  }

  function set_down(address _down) {
    down = _down;
  }

  function set_ether(uint _ether) {
    ether = _ether;
  }

  function set_inhabitant(address _inhabitant) {
    inhabitant = _inhabitant;
  }

  function set_left(address _left) {
    left = _left;
  }

  function set_right(address _right) {
    right = _right;
  }

  function set_up(address _up) {
    up = _up;
  }
}
