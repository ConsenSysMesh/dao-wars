from eth_tools import Contract, address
from nose.tools import assert_equal
from pyethereum import tester as t

REWRITE_STATE = 0
GET_LEFT = 1
GET_ETHER = 5
GET_ADMIN = 7

class TestSquare:
    def setup(self):
        self.state = t.state()
        self.contract = Contract("contracts/square.se", self.state)

    def test_left(self):
        self.contract.call(REWRITE_STATE, [t.a1, 0, 0, 0, 0, 0, 0])
        assert_equal(address(self.contract.call(GET_LEFT)[0]), t.a1)

    def test_ether(self):
        self.contract.call(REWRITE_STATE, [0, 0, 0, 0, 1000, 0, 0])
        assert_equal(self.contract.call(GET_ETHER), [1000])

    def test_locks_changes_to_non_admins(self):
        self.contract.call(REWRITE_STATE, [0, 0, 0, 0, 1000, 0, t.a0])
        assert_equal(address(self.contract.call(GET_ADMIN)[0]), t.a0)

        self.contract.call(REWRITE_STATE, [0, 0, 0, 0, 1001, 0, t.a0])
        self.contract.call(REWRITE_STATE, [0, 0, 0, 0, 1002, 0, 0], sender=t.k1)
        assert_equal(self.contract.call(GET_ETHER), [1001])
