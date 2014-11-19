from eth_tools import Contract, address
from nose.tools import assert_equal
from pyethereum import tester as t

class TestBody:
    def setup(self):
        self.state = t.state()
        self.contract = Contract("contracts/body.se", self.state)
        self.contract.call(0, [])

    def test_move_left(self):
        location = Contract("contracts/square.se", self.state)
        neighbor = Contract("contracts/square.se", self.state)

        location.call(13, [])
        location.call(1, [neighbor.contract])
        self.contract.call(6, [location.contract])

        assert_equal(address(self.contract.call(5, [])[0]), location.contract)

        self.contract.call(1, [])

        assert_equal(address(self.contract.call(5, [])[0]), neighbor.contract)
