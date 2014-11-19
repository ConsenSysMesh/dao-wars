contract Mul2 {
  function get_down() returns (address down) {
    down = down_neighbor;
  }

  function get_left() returns (address left) {
    left = left_neighbor;
  }

  function get_right() returns (address right) {
    right = right_neighbor;
  }

  function get_up() returns (address up) {
    up = up_neighbor;
  }

  function set_down(address new_down) {
    down_neighbor = new_down;
  }

  function set_left(address new_left) {
    left_neighbor = new_left;
  }

  function set_right(address new_right) {
    right_neighbor = new_right;
  }

  function set_up(address new_up) {
    up_neighbor = new_up;
  }

  address left_neighbor;
  address right_neighbor;
  address up_neighbor;
  address down_neighbor;
}
