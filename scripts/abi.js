var initializer_abi = [{
    "name": "_finish_game(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": [{ "name": "unknown_out", "type": "int256[]" }]
},
{
    "name": "create_game(int256,int256,int256,int256,int256,int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }, { "name": "brain_1", "type": "int256" }, { "name": "brain_2", "type": "int256" }, { "name": "size", "type": "int256" }, { "name": "starting_gas", "type": "int256" }, { "name": "gas_per_square", "type": "int256" }],
    "outputs": [{ "name": "unknown_out", "type": "int256[]" }]
},
{
    "name": "get_game_board(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_game_phase(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_gamemaster(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "take_all_actions(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": []
},
{
    "name": "take_single_action(int256)",
    "type": "function",
    "inputs": [{ "name": "id", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
}]


var gamemasterAbi = [{
  "name": "_num_surviving_species()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
    },
{
  "name": "_update_species_counts()",
  "type": "function",
  "inputs": [],
  "outputs": []
},
{
  "name": "get_finished()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_creatures()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256[]" }]
},
{
  "name": "get_num_creatures()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_species_creature_counts()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256[]" }]
},
{
  "name": "get_turn_limit()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "notify_of_spawn(int256)",
  "type": "function",
  "inputs": [{ "name": "new_creature", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "run_game()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "run_turn()",
  "type": "function",
  "inputs": [],
  "outputs": []
},
{
  "name": "set_admin(int256)",
  "type": "function",
  "inputs": [{ "name": "_admin", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_creatures(int256,int256)",
  "type": "function",
  "inputs": [{ "name": "creature_1", "type": "int256" }, { "name": "creature_2", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_turn_limit(int256)",
  "type": "function",
  "inputs": [{ "name": "_turn_limit", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
}]

var creatureAbi = [{
  "name": "attack(int256)",
  "type": "function",
  "inputs": [{ "name": "direction", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "damage()",
  "type": "function",
  "inputs": [],
  "outputs": []
},
{
  "name": "deduct_gas(int256)",
  "type": "function",
  "inputs": [{ "name": "amount", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_brain()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_dead()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_gamemaster()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_gas()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_hp()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_location()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "get_species()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{    "name": "harvest()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "move(int256)",
  "type": "function",
  "inputs": [{ "name": "direction", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "notify_body_of_turn()",
  "type": "function",
  "inputs": [],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "reproduce(int256,int256,int256)",
  "type": "function",
  "inputs": [{ "name": "direction", "type": "int256" }, { "name": "new_brain", "type": "int256" }, { "name": "endowment", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_brain(int256)",
  "type": "function",
  "inputs": [{ "name": "_brain", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_creature_builder(int256)",
  "type": "function",
  "inputs": [{ "name": "_creature_builder", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_gamemaster(int256)",
  "type": "function",
  "inputs": [{ "name": "_gamemaster", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_gas(int256)",
  "type": "function",
  "inputs": [{ "name": "_gas", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_hp(int256)",
  "type": "function",
  "inputs": [{ "name": "_hp", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_location(int256)",
  "type": "function",
  "inputs": [{ "name": "_location", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
},
{
  "name": "set_species(int256)",
  "type": "function",
  "inputs": [{ "name": "_species", "type": "int256" }],
  "outputs": [{ "name": "out", "type": "int256" }]
}]

boardAbi = [{
    "name": "_assign_gas()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "_assign_single_neighbor()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "_create_single_square()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "unknown_out", "type": "int256[]" }]
},
{
    "name": "get_current_x()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_current_y()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_square(int256,int256)",
    "type": "function",
    "inputs": [{ "name": "x", "type": "int256" }, { "name": "y", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_x()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_y()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_dimensions(int256,int256)",
    "type": "function",
    "inputs": [{ "name": "x", "type": "int256" }, { "name": "y", "type": "int256" }],
    "outputs": []
},
{
    "name": "set_gas_amount(int256)",
    "type": "function",
    "inputs": [{ "name": "amount", "type": "int256" }],
    "outputs": []
},
{
    "name": "take_single_action()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }],
},
{
    "name": "validate_square(int256,int256)",
    "type": "function",
    "inputs": [{ "name": "x", "type": "int256" }, { "name": "y", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }],
}]

squareAbi = [{
    "name": "claim_harvest()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "drop_gas(int256)",
    "type": "function",
    "inputs": [{ "name": "amount", "type": "int256" }],
    "outputs": []
},
{
    "name": "enter()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "get_creature()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_gamemaster()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_gas()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_neighbor(int256)",
    "type": "function",
    "inputs": [{ "name": "direction", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_neighbors()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "leave()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "set_creature(int256)",
    "type": "function",
    "inputs": [{ "name": "_creature", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_gamemaster(int256)",
    "type": "function",
    "inputs": [{ "name": "_gamemaster", "type": "int256" }],
    "outputs": []
},
{
    "name": "set_gas(int256)",
    "type": "function",
    "inputs": [{ "name": "_gas", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_neighbors(int256,int256,int256,int256)",
    "type": "function",
    "inputs": [{ "name": "left", "type": "int256" }, { "name": "right", "type": "int256" }, { "name": "up", "type": "int256" }, { "name": "down", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "spawn(int256)",
    "type": "function",
    "inputs": [{ "name": "creature", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "validate()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
}]

creatureAbi = [{
    "name": "attack(int256)",
    "type": "function",
    "inputs": [{ "name": "direction", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "damage()",
    "type": "function",
    "inputs": [],
    "outputs": []
},
{
    "name": "deduct_gas(int256)",
    "type": "function",
    "inputs": [{ "name": "amount", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_brain()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_dead()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_gamemaster()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_gas()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_hp()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_location()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "get_species()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "harvest()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "move(int256)",
    "type": "function",
    "inputs": [{ "name": "direction", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "notify_body_of_turn()",
    "type": "function",
    "inputs": [],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "reproduce(int256,int256,int256)",
    "type": "function",
    "inputs": [{ "name": "direction", "type": "int256" }, { "name": "new_brain", "type": "int256" }, { "name": "endowment", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_brain(int256)",
    "type": "function",
    "inputs": [{ "name": "_brain", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_creature_builder(int256)",
    "type": "function",
    "inputs": [{ "name": "_creature_builder", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_gamemaster(int256)",
    "type": "function",
    "inputs": [{ "name": "_gamemaster", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_gas(int256)",
    "type": "function",
    "inputs": [{ "name": "_gas", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_hp(int256)",
    "type": "function",
    "inputs": [{ "name": "_hp", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_location(int256)",
    "type": "function",
    "inputs": [{ "name": "_location", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
},
{
    "name": "set_species(int256)",
    "type": "function",
    "inputs": [{ "name": "_species", "type": "int256" }],
    "outputs": [{ "name": "out", "type": "int256" }]
}]
