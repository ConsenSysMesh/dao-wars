contract BrainMock {
  uint public times_called;

  function notify_of_turn() {
    times_called++;
  }
}
