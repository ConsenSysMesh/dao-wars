contract Body {
  address location;
  uint hp;
  uint ether;
  uint species;
  address brain;
   
  function get_location() returns (address _location) {
    _location = location;
  }

  function set_brain(address _brain) {
    brain = _brain;
  }

  function set_ether(address _ether) {
    ether = _ether;
  }

  function set_hp(address _hp) {
    hp = _hp;
  }

  function set_location(address _location) {
    location = _location;
  }

  function set_species(address _species) {
    species = _species;
  }
}
