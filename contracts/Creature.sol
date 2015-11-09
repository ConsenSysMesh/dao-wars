import "Board";

contract CreatureBuilderStub {
  function build_creature() returns (Creature result) {}
}

contract BrainStub {
  function ping();
}

contract Creature {
  address public admin;
  uint public eth;
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

  function ping() {
    if (last_turn < block.number && tx.gasprice <= max_gasprice) {
      turn_active = true;
      uint max_gas = (eth  / (tx.gasprice * 11/10)) - 2000;

      uint starting_gas = msg.gas;
      BrainStub(brain).ping();

      uint total_gas = (starting_gas - msg.gas) + 2000;
      uint spent_eth = (total_gas * (tx.gasprice * 11/10));

      if (eth > spent_eth) {
        eth -= spent_eth;
      } else {
        eth = 0;
      }
      msg.sender.send(spent_eth);
    }
  }

  function set_maxgasprice(uint _max) auth(brain) {
    max_gasprice = _max;
  }

  function withdraw_eth(uint amount) auth(brain) {
    if (amount < eth) {
      brain.send(amount);
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

  function set_eth(uint _eth) auth(admin) {
    eth = _eth;
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
    eth += board.harvest(location);
  }

  function attack(uint8 direction) requires_turn {
    uint target = board.neighbor(location, direction);
    Creature target_creature = Creature(board.creatures(target));
    target_creature.damage();
  }

  function reproduce(uint8 direction, address new_brain, uint endowment) requires_turn {
    uint target = board.neighbor(location, direction);
    if ((board.creatures(target) == 0) && (endowment <= eth)) {
      Creature new_creature = creature_builder.build_creature();

      new_creature.set_location(target);
      new_creature.set_hp(3);
      new_creature.set_species(species);
      new_creature.set_board(board);
      new_creature.set_game(game);
      new_creature.set_eth(endowment);
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
        board.report_death(location, eth);
        suicide(board);
      }
    }
  }
}
