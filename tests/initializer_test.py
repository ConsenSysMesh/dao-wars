from nose.tools import assert_equal, assert_not_equal
from pyethereum import tester as t

class TestInitializer:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/initializer.se")

    def test_it_does_not_blow_up(self):
        self.contract.create_game(42, 0, 0, 2, 40000, 200000)

        iterations = 0

        while self.contract.take_single_action(42) == 0:
            iterations += 1

        assert_equal(iterations, 7)

        game = self.contract.get_game(42)
        assert_not_equal(game[0], 0)
        assert_equal(game[1], 2)
        assert_not_equal(game[2], 0)
