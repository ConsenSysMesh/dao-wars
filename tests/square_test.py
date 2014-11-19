from eth_tools import Contract, address
from nose.tools import assert_equal
from pyethereum import tester as t

class TestSquare:
    def setup(self):
        self.state = t.state()
        self.contract = Contract("contracts/square.se", self.state)
        self.contract.call(13, [])

    def test_left(self):
        self.contract.call(1, [t.a0])
        assert_equal(address(self.contract.call(0, [])[0]), t.a0)

    def test_ether(self):
        self.contract.call(9, [1000])
        assert_equal(self.contract.call(8,[]), [1000])

    def test_only_allows_admin_to_set(self):
        self.contract.call(9, [1000])
        self.contract.call(9, [1001], sender=t.k1)
        assert_equal(self.contract.call(8,[]), [1000])
