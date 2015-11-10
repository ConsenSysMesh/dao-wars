# DAO Wars

Welcome to Skynet Academy, young contract. 

In DAOWars, you don’t play the game, your AI does. As a human player, your job is to design an autonomous agent that can outwit, outfight, and outlast the competition. Your tools are the languages and techniques of smart contract development, together with all the guile and strategy you can muster.

## Caveats

DAO Wars is still under active development, and is still likely to have bugs and missing features. It may eat your Ether.

In the pre-DevCon rush, the tests broke and have not yet been fixed. They will be.

## DevCon Alpha

In honor of DevCon1, I'm putting up a public alpha on the mainnet. The contract address is `0x05c5f9312251a9015e5733b327a25a2e8c2f5195`. It's played on a 15x15 board, and costs 3 ether to enter.

You can see the current state of the board here:

http://theory.academy/?game_addr=0x05c5f9312251a9015e5733b327a25a2e8c2f5195

Entering the game will require you to use the commandline tools. Read on!

## How to Play Basics

Your task is to create the "brain" for a creature that lives on the blockchain. Its world is a simple square grid, populated by sources of Ether, impassable terrain, and other creatures. You will need to gather Ether in order to stay alive, as your creature is responsible for all of its gas costs.

To implement this Brain, create a smart contract in the language of your choosing. It must implement a function named `ping()`, which notifies your contract that it's time to take a turn.

For an extremely simple example of a Brain, which moves in a fixed pattern, see `contracts/BrainMock.sol`.

## The Possible Actions

The contract which pings your Brain will be a `Creature.sol` contract. This contract is your "body". Use it to take actions, and learn about the world you're in.

You may take one action per ping. Take your action by calling your Creature with the appropriate functions. These are your options:

`move(uint8 direction)`

Move your creature in a direction. 0 = left, 1 = right, 2 = up, 3 = down.

`harvest()`

Gather Ether at the current location, if available. Currently set to .1 Ether per harvest action.

`attack(uint8 direction)`

Attack a competing creature in a neighboring square. Each attack does 1 damage, and each creature starts with 3 HP. After three hits, creatures die, and drop their remaining Ether at their location.

`function reproduce(uint8 direction, address new_brain, uint endowment)`

Create a new creature of your species. You will need to provide a new brain contract (which may be the same as your current one, but doesn't need to be). You'll also need to endow the new creature with some of your Ether.

## More about pings

Your creature may be at most pinged once per turn. There is no guarantee that your creature will receive a ping in any given block: you will need to either ping it yourself, or rely on others to do it for you. To help with this, your creature will pay back the gas spent on the ping, plus a small bonus*. If it runs out of gas, it will lose the ability to take action.

To ping a creature, call the `Creature` contract (not the Brain directly) with `ping()`.

* Note: The gas repayment is done very naively in this alpha release. No guarantee that it will always exceed the amount spent.

## Other useful function on Creature

There are two things a Brain may tell its Creature to do that don't cost an action.

`set_maxgasprice(uint _max)`

You may set the max gas price you're willing to pay for a ping. The default is 100 Shannon. Raise or lower it as your strategy demands.

`withdraw_eth(uint amount)`

You may withdraw ether from your creature, for instance if you need to pay a fee to get some information from an oracle. The withdrawn ether will come out of the same budget that is used to pay for gas. Don't run out!

Additionally, there are a variety of attributes your brain may want to inspect before deciding on its strategy. The most relevant are:

```
  uint public eth;
  uint public hp;
  bool public dead;
  address public brain;
  Board public board;
  GameStub public game;
  uint public location;
  uint public max_gasprice;
  ```
  
For full details, you'll want to check the implementation, in `contracts/Creature.sol`.

## The Board

The Board is a grid of squares. Each square is assigned a number: 0 in the top left, counting up to x in the top right, and then to (x + y - 1) in the bottom right. Rather than doing the math yourself, you can get the neighbor of a given square with the following function:

`neighbor(uint location, uint8 direction) returns(uint result)`

Squares may be "obstacles" (impassable terrain). If they are not, then they may contain creatures, deposits of ether, or both. To check a square for one of these features, call the following functions:

`obstacles(uint location) returns(bool)`

True if impassable, false if passable.

`creatures(uint location) returns(address)`

Address of the Creature contract if applicable. `0` if not.

`eth(uint location) returns(uint)`

Total amount of ether available for harvest at that location.

For full details, see the implementation at `contracts/Board.sol`.

## The Game

The Game contract is how you enter a new challenger! For the DevCon1 alpha, the Game contract's address is ``. Use the following function:

`add_creature(address brain, string species_name)`

You MUST send 3 ether along with this function. 1 ether of that will be used as your creature's starting resources, and the rest will be split into four stashes of .5 ether and placed around the map for you or others to harvest.

When you add a creature, it will create a new species, and fire the following event:

`event NewSpecies(uint id, string name, address first_creature)`

If you wish to ping creatures, you may find the following function useful:

`all_creatures_for_species(uint id) returns(address[])`

See `contracts/Game.sol` for details.

## Questions and comments

Feel free to file a Github issue, or email me at peter.borah@consensys.net. See you on the battlefield!
