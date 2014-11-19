contract Mul2 {
  function get_down() returns (address down) {
    down = current_down;
  }

  function get_ether() returns (uint ether) {
    ether = current_ether;
  }

  function get_inhabitant() returns (address inhabitant) {
    inhabitant = current_inhabitant;
  }

  function get_left() returns (address left) {
    left = current_left;
  }

  function get_right() returns (address right) {
    right = current_right;
  }

  function get_up() returns (address up) {
    up = current_up;
  }

  function set_down(address new_down) {
    current_down = new_down;
  }

  function set_ether(uint new_ether) {
    current_ether = new_ether;
  }

  function set_inhabitant(address new_inhabitant) {
    current_inhabitant = new_inhabitant;
  }

  function set_left(address new_left) {
    current_left = new_left;
  }

  function set_right(address new_right) {
    current_right = new_right;
  }

  function set_up(address new_up) {
    current_up = new_up;
  }

  address current_left;
  address current_right;
  address current_up;
  address current_down;
  address current_inhabitant;
  uint current_ether;
}
