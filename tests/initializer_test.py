from nose.tools import assert_equal, assert_not_equal
from pyethereum import tester as t

class TestInitializer:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/initializer.se")

    def test_it_does_not_blow_up(self):
        gamemaster = self.contract.create_game(1,2)
        assert_not_equal(gamemaster, 0)
        assert_equal(gamemaster, self.contract.get_latest_gamemaster())
