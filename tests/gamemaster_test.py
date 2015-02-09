from eth_tools import address
from nose.tools import assert_equal
from pyethereum import tester as t

class TestGamemaster:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/gamemaster.se")

    def test_can_create_game(self):
        player_list = [3, 4]
        self.contract.rewrite_state(player_list, 100)

        assert_equal(self.contract.get_player_list(outsz=2), player_list)
        assert_equal(self.contract.get_num_players(), [2])
        assert_equal(self.contract.get_move_limit(), [100])

    def test_only_creator_can_rewrite_state(self):
        player_list = [3, 4]
        self.contract.rewrite_state(player_list, 100)

        assert_equal(self.contract.rewrite_state(player_list, 50, sender=t.k1), [-1])
        assert_equal(self.contract.get_move_limit(), [100])
