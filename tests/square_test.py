from eth_tools import address
from nose.tools import assert_equal
from pyethereum import tester as t

class TestSquare:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/square.se")

    def test_left(self):
        self.contract.set_neighbors([t.a1, 0, 0, 0])
        assert_equal(address(self.contract.get_neighbor("left")[0]), t.a1)

    def test_gas(self):
        self.contract.set_gas(1000)
        assert_equal(self.contract.get_gas(), [1000])

    def test_locks_changes_to_non_gamemasters(self):
        self.contract.set_gas(1000)
        assert_equal(address(self.contract.get_gamemaster()[0]), t.a0)

        self.contract.set_gas(1001)
        self.contract.set_gas(1002, sender=t.k1)
        assert_equal(self.contract.get_gas(), [1001])
