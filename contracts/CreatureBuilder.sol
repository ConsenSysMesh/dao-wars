import "Creature";

contract CreatureBuilder {
  function build_creature() returns (Creature result) {
    result = new Creature();
    result.set_admin(msg.sender);
    return result;
  }
}
