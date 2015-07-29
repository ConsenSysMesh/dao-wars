contract BrainMock {
  uint public times_called;

  function notify_of_turn() {
    times_called++;
  }

  function reset() {
    times_called = 0;
  }
}
