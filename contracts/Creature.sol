import "Square";

contract Creature {
  Square public square;

  function set_square(Square _square) {
    square = _square;
  }

  function move(uint direction) {
    Square new_square = square.neighbors(direction);
    if (new_square.creature() == 0) {
      square.leave();
      new_square.enter();
      square = new_square;
    }
  }
}
