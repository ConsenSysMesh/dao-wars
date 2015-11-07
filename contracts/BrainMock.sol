import_headers "Creature";

contract BrainMock {
  uint public times_called;

  function notify_of_turn() {
    Creature(msg.sender).move(times_called % 4);
    times_called++;
  }

  function reset() {
    times_called = 0;
  }
}
