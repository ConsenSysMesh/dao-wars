import "Board";
import "Gamemaster";

contract Game {
  Board public board;
  Gamemaster public gamemaster;
  address public admin;
  uint8 public gas_deposits;
  uint public gas_amount;

  modifier auth(address authorized_user) { if (msg.sender == authorized_user) _ }

  function Game() {
    admin = msg.sender;
  }

  function initialize(uint x, uint y, uint8 _gas_deposits, uint _gas_amount) auth(admin) {
    board = new Board();
    board.set_dimensions(x, y);

    gamemaster = new Gamemaster();
    gamemaster.set_board(board);
    board.set_gamemaster(gamemaster);

    gas_deposits = _gas_deposits;
    gas_amount = _gas_amount;
  }

  function run_turn() auth(admin) {
    gamemaster.run_turn();
  }

  function add_creature(address creature) {
    board.add_creature(creature);
    board.deposit_gas(gas_deposits, gas_amount);  
  }
}
