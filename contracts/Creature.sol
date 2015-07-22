import "Square";

contract Creature {
  Square public square;
  uint public gas;
  uint8 public hp;
  bool public dead;

  function Creature() {
    dead = false;
  }

  function set_square(Square _square) {
    square = _square;
  }

  function set_hp(uint8 _hp) {
    hp = _hp;
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

  function attack(uint direction) {
    Square target_square = square.neighbors(direction);
    Creature target = Creature(target_square.creature());
    target.damage();
  }

  function damage() {
    hp -= 1;
    if (hp == 0) {
      dead = true;
      square.leave();
    }
  }
}
