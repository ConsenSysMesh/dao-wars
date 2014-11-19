from eth_tools import Contract
from nose.tools import assert_equal
from pyethereum import tester as t

class TestSquare:
    def setup(self):
        self.contract = Contract("contracts/square.sol")

    def test_left(self):
        self.contract.call(5, [t.a0])
        # The following nonsense is because addresses as a datatype don't seem to work, yet.
        # Also, the dumb function numbers is because it forces alphabetical order...
        assert_equal(hex(self.contract.call(1, [])[0]).lstrip("0x").rstrip("L"), t.a0[0:16])
