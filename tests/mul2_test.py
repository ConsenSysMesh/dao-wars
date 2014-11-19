from eth_tools import Contract
from nose.tools import assert_equal

class TestMul2:
    def setup(self):
        self.contract = Contract("contracts/mul2.sol")

    def test_multiplies(self):
        assert_equal(self.contract.call(0, [42]), [84])
