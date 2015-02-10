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

    def test_run_game_calls_down_to_brain_through_body(self):
        brain_1 = self.state.abi_contract("mocks/brain/counter.se")
        brain_2 = self.state.abi_contract("mocks/brain/counter.se")

        player_1 = self.state.abi_contract("contracts/body.se")
        player_1.rewrite_state(0, 0, 0, brain_1.address, 0, 0, 0)

        player_2 = self.state.abi_contract("contracts/body.se")
        player_2.rewrite_state(0, 0, 0, brain_2.address, 0, 0, 0)

        self.contract.rewrite_state([player_1.address, player_2.address], 5)
        self.contract.run_game()

        assert_equal(brain_1.get_num_moves(), [5])
        assert_equal(brain_2.get_num_moves(), [5])

    def test_acting_player_can_spawn_new_creatures(self):
        child = self.state.abi_contract("mocks/brain/counter.se")
        body = self.state.abi_contract("mocks/body/spawner.se")
        body.set_child_address(child.address)
        self.contract.rewrite_state([body.address], 1)

        self.contract.run_game()

        assert_equal(self.contract.get_num_players(), [2])
        assert_equal(child.get_num_moves(), [1])

    def test_only_acting_player_can_spawn(self):
        self.contract.rewrite_state([t.a1], 5)

        assert_equal(self.contract.notify_of_spawn(t.a0), [-1])
        assert_equal(self.contract.get_num_players(), [1])
