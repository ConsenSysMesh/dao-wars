import "Board";

contract CreatureBuilderStub {
  function build_creature() returns (Creature result) {}
}

contract BrainStub {
  function notify_of_turn() {}
}

contract Creature {
  address public admin;
  uint public gas;
  uint public hp;
  bool public dead;
  uint public species;
  address public brain;
  CreatureBuilderStub public creature_builder;
  bool public turn_active;
  address public gamemaster;
  Board public board;
  uint public location;

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
    BrainStub(brain).notify_of_turn();
  }

  function set_hp(uint _hp) auth(admin) {
    hp = _hp;
  }

  function set_species(uint _species) auth(admin) {
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

  function set_creature_builder(CreatureBuilderStub _creature_builder) auth(admin) {
    creature_builder = _creature_builder;
  }

  function set_gamemaster(address _gamemaster) auth(admin) {
    gamemaster = _gamemaster;
  }

  function set_board(Board _board) auth(admin) {
    board = _board;
  }

  function set_location(uint _location) auth(admin) {
    location = _location;
  }

  function deduct(uint amount) auth(gamemaster) {
    if (amount < gas) {
      gas -= amount;
    } else {
      gas = 0;
      dead = true;
    }
  }

  function move(uint8 direction) requires_turn {
    uint target = board.neighbor(location, direction);
    if (board.creature_at_location(target) == 0) {
      board.leave_square(location);
      board.enter_square(target);
      location = target;
    }
  }

  function harvest() requires_turn {
    gas += board.harvest(location);
  }

  function attack(uint8 direction) requires_turn {
    uint target = board.neighbor(location, direction);
    Creature target_creature = Creature(board.creature_at_location(target));
    target_creature.damage();
  }

  function reproduce(uint8 direction, address new_brain, uint endowment) requires_turn {
    uint target = board.neighbor(location, direction);
    if ((board.creature_at_location(target) == 0) && (endowment <= gas)) {
      Creature new_creature = creature_builder.build_creature();

      new_creature.set_location(target);
      new_creature.set_hp(3);
      new_creature.set_species(species);
      new_creature.set_board(board);

      new_creature.set_admin(admin);

      board.spawn(target, address(new_creature));
    }
  }

  function damage() {
    hp -= 1;
    if (hp == 0) {
      dead = true;
      board.report_death(location, gas);
    }
  }
}
