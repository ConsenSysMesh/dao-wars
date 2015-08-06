import "Board";
import "Gamemaster";

contract Game {
  Board public board;
  Gamemaster public gamemaster;

  function Game() {
  }

  function initialize(uint x, uint y) {
    board = new Board();
    board.set_dimensions(x, y);

    gamemaster = new Gamemaster();
    gamemaster.set_board(board);
    board.set_gamemaster(gamemaster);
  }
}
