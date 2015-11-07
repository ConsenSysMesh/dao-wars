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
  Board public board;
  GameStub public game;
  uint public location;
  uint public last_turn;
  uint public max_gasprice;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }
  modifier requires_turn {
    if (turn_active && (msg.sender == brain)) {
      turn_active = false;
      _
    }
  }

  function Creature() {
    admin = msg.sender;
    max_gasprice = 100 * 10 ** 9; // 100 Shannon, 2x the minimum
  }

  function validate() returns (uint8 result) {
    return 42;
  }

  function notify_of_turn() {

    if (last_turn < block.number && tx.gasprice <= max_gasprice) {
      turn_active = true;
      uint max_gas = gas / (tx.gasprice * 11/10);

      uint starting_gas = msg.gas;
      BrainStub(brain).notify_of_turn.gas(max_gas)();
      
      uint total_gas = starting_gas - msg.gas;
      uint spent_gas = (total_gas * (tx.gasprice * 11/10));
      
      gas -= spent_gas;
      msg.sender.send(spent_gas);
    }
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

  function set_creature_builder(address _creature_builder) auth(admin) {
    creature_builder = CreatureBuilderStub(_creature_builder);
  }

  function set_board(Board _board) auth(admin) {
    board = _board;
  }

  function set_game(address _game) auth(admin) {
    game = GameStub(_game);
  }

  function set_location(uint _location) auth(admin) {
    location = _location;
  }

  function move(uint8 direction) requires_turn {
    uint target = board.neighbor(location, direction);
    if (board.creatures(target) == 0) {
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
    Creature target_creature = Creature(board.creatures(target));
    target_creature.damage();
  }

  function reproduce(uint8 direction, address new_brain, uint endowment) requires_turn {
    uint target = board.neighbor(location, direction);
    if ((board.creatures(target) == 0) && (endowment <= gas)) {
      Creature new_creature = creature_builder.build_creature();

      new_creature.set_location(target);
      new_creature.set_hp(3);
      new_creature.set_species(species);
      new_creature.set_board(board);
      new_creature.set_game(game);
      new_creature.set_gas(endowment);
      new_creature.set_creature_builder(creature_builder);

      new_creature.set_admin(admin);

      new_creature.send(endowment);
      board.spawn(target, address(new_creature));
    }
  }

  function damage() {
    if (game.valid_creature(msg.sender) == true) {
      hp -= 1;
      if (hp == 0) {
        dead = true;
        board.report_death(location, gas);
        suicide(board);
      }
    }
  }
}
