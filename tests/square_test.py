from eth_tools import address
from nose.tools import assert_equal
from pyethereum import tester as t

class TestSquare:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/square.se")

    def test_left(self):
        self.contract.rewrite_state(t.a1, 0, 0, 0, 0, 0, 0)
        assert_equal(address(self.contract.get_left()[0]), t.a1)

    def test_gas(self):
        self.contract.rewrite_state(0, 0, 0, 0, 1000, 0, 0)
        assert_equal(self.contract.get_gas(), [1000])

    def test_locks_changes_to_non_admins(self):
        self.contract.rewrite_state(0, 0, 0, 0, 1000, 0, t.a0)
        assert_equal(address(self.contract.get_admin()[0]), t.a0)

        self.contract.rewrite_state(0, 0, 0, 0, 1001, 0, t.a0)
        self.contract.rewrite_state(0, 0, 0, 0, 1002, 0, 0, sender=t.k1)
        assert_equal(self.contract.get_gas(), [1001])
