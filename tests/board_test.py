from nose.tools import assert_equal
from pyethereum import tester as t

class TestBoard:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/board.se")

    def test_it_does_not_blow_up(self):
        self.contract.create_board(10,10)
