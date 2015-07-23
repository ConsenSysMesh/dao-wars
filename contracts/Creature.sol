import "Square";

contract StubCreatureBuilder {
  function build_creature() returns (Creature result) {}
}

contract StubBrain {
  function notify_of_turn() {}
}

contract Creature {
  address public admin;
  Square public square;
  uint public gas;
  uint8 public hp;
  bool public dead;
  uint8 public species;
  address public brain;
  StubCreatureBuilder public creature_builder;
  bool public turn_active;
  address public gamemaster;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }
  modifier requires_turn {
    if (turn_active && (msg.sender == brain)) {
      turn_active = false;
      _
    }
  }

  function Creature() {
    admin = msg.sender;
  }

  function validate() returns (uint8 result) {
    return 42;
  }

  function notify_of_turn() auth(gamemaster) {
    turn_active = true;
    StubBrain(brain).notify_of_turn();
  }

  function set_square(Square _square) auth(admin) {
    square = _square;
  }

  function set_hp(uint8 _hp) auth(admin) {
    hp = _hp;
  }

  function set_species(uint8 _species) auth(admin) {
    species = _species;
  }

  function set_brain(address _brain) auth(admin) {
    brain = _brain;
  }

  function set_admin(address _admin) auth(admin) {
    admin = _admin;
  }

  function set_gas(uint _gas) auth(admin) {
    gas = _gas;
  }

  function set_creature_builder(StubCreatureBuilder _creature_builder) auth(admin) {
    creature_builder = _creature_builder;
  }

  function set_gamemaster(address _gamemaster) auth(admin) {
    gamemaster = _gamemaster;
  }

  function move(uint direction) requires_turn {
    Square new_square = square.neighbors(direction);
    if (new_square.creature() == 0) {
      square.leave();
      new_square.enter();
      square = new_square;
    }
  }

  function harvest() requires_turn {
    gas += square.harvest();
  }

  function attack(uint direction) requires_turn {
    Square target_square = square.neighbors(direction);
    Creature target = Creature(target_square.creature());
    target.damage();
  }

  function reproduce(uint direction, address new_brain, uint endowment) requires_turn {
    Square target_square = square.neighbors(direction);
    if ((target_square.creature() == 0) && (endowment <= gas)) {
      Creature new_creature = creature_builder.build_creature();

      new_creature.set_square(target_square);
      new_creature.set_hp(3);
      new_creature.set_species(species);
      new_creature.set_gas(endowment);
      new_creature.set_brain(new_brain);

      new_creature.set_admin(admin);

      target_square.spawn(address(new_creature));
    }
  }

  function damage() {
    hp -= 1;
    if (hp == 0) {
      dead = true;
      square.report_death(gas);
    }
  }
}
