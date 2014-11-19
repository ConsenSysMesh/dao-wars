from eth_tools import Contract, address
from nose.tools import assert_equal
from pyethereum import tester as t

REWRITE_STATE = 0
MOVE_LEFT = 1
GET_LOCATION = 5

SQUARE_REWRITE_STATE = 0

class TestBody:
    def setup(self):
        self.state = t.state()
        self.contract = Contract("contracts/body.se", self.state)

    def test_move_left(self):
        location = Contract("contracts/square.se", self.state)
        neighbor = Contract("contracts/square.se", self.state)

        location.call(SQUARE_REWRITE_STATE, [neighbor.contract, 0, 0, 0, 0, 0, t.a0])
        self.contract.call(REWRITE_STATE, [location.contract, 0, 0, 0, 0, t.a0])

        assert_equal(address(self.contract.call(GET_LOCATION)[0]), location.contract)

        self.contract.call(MOVE_LEFT)

        assert_equal(address(self.contract.call(GET_LOCATION)[0]), neighbor.contract)
