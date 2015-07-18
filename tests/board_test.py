from nose.tools import assert_equal, assert_not_equal
from pyethereum import tester as t

class TestBoard:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/board.se")

    def test_it_does_not_blow_up(self):
        self.contract.set_dimensions(10,10)
        self.contract.set_gas_amount(40000)
        phase = 0
        while phase != 3:
            phase = self.contract.take_single_action()
            print phase

        assert_not_equal(self.contract.get_square(0,0), 0)
        assert_not_equal(self.contract.get_square(0,1), 0)
        assert_not_equal(self.contract.get_square(1,0), 0)
        assert_not_equal(self.contract.get_square(9,9), 0)

        assert_equal(self.contract.get_square(10,9), 0)
        assert_equal(self.contract.get_square(9,10), 0)

        neighbor_validator = self.state.abi_contract("validators/neighbor_validator.se")
        print self.contract.address
        print neighbor_validator.validate(self.contract.address)
