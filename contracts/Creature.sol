import "Square";

contract Creature {
  Square public square;
  uint public gas;

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

  function harvest() {
    gas += square.harvest();
  }
}
