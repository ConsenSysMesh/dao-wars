import_headers "Creature";

contract BrainMock {
  uint public times_called;

  function ping() {
    Creature(msg.sender).move(uint8(times_called % 4));
    times_called++;
  }

  function reset() {
    times_called = 0;
  }
}
