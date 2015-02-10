from eth_tools import address
from nose.tools import assert_equal, assert_not_equal
from pyethereum import tester as t

class TestBody:
    def setup(self):
        self.state = t.state()
        self.contract = self.state.abi_contract("contracts/body.se")

    def test_move_left(self):
        location = self.state.abi_contract("contracts/square.se")
        neighbor = self.state.abi_contract("contracts/square.se")

        location.rewrite_state(neighbor.address, 0, 0, 0, 0, self.contract.address, t.a0)
        assert_equal(address(location.get_creature()[0]), self.contract.address)
        self.contract.notify_of_turn()

        self.contract.rewrite_state(location.address, 0, 0, 0, 0, t.a0, 0)
        assert_equal(address(self.contract.get_location()[0]), location.address)

        self.contract.move_left()

        assert_equal(address(self.contract.get_location()[0]), neighbor.address)
        assert_equal(location.get_creature(), [0])
        assert_equal(address(neighbor.get_creature()[0]), self.contract.address)

    def test_harvest(self):
        location = self.state.abi_contract("contracts/square.se")
        location.rewrite_state(0, 0, 0, 0, 150, self.contract.address, t.a0)
        self.contract.rewrite_state(location.address, 0, 0, 0, 0, t.a0, 0)
        self.contract.notify_of_turn()

        assert_equal(location.get_ether(), [150])
        assert_equal(self.contract.get_ether(), [0])

        assert_equal(self.contract.harvest(), [100])
        assert_equal(location.get_ether(), [50])
        assert_equal(self.contract.get_ether(), [100])

        self.contract.notify_of_turn()
        self.contract.harvest()
        assert_equal(location.get_ether(), [0])
        assert_equal(self.contract.get_ether(), [150])

    def test_attack_left(self):
        location = self.state.abi_contract("contracts/square.se")
        neighbor = self.state.abi_contract("contracts/square.se")
        enemy = self.state.abi_contract("contracts/body.se")

        location.rewrite_state(neighbor.address, 0, 0, 0, 0, self.contract.address, t.a0)
        neighbor.rewrite_state(0, location.address, 0, 0, 0, enemy.address, t.a0)
        enemy.rewrite_state(neighbor.address, 0, 3, 0, 0, t.a0, 0)
        self.contract.rewrite_state(location.address, 0, 0, 0, 0, t.a0, 0)
        assert_equal(enemy.get_hp(), [3])
        self.contract.notify_of_turn()

        self.contract.attack_left()

        assert_equal(enemy.get_hp(), [2])

    def test_reproduce_left(self):
        location = self.state.abi_contract("contracts/square.se")
        neighbor = self.state.abi_contract("contracts/square.se")
        creature_builder = self.state.abi_contract("contracts/creature_builder.se")

        location.rewrite_state(neighbor.address, 0, 0, 0, 0, self.contract.address, t.a0)
        self.contract.rewrite_state(location.address, 0, 0, 0, 0, t.a0, creature_builder.address)
        self.contract.notify_of_turn()

        assert_equal(neighbor.get_creature(), [0])

        new_body_address = address(self.contract.reproduce_left(t.a1, 0)[0])

        assert_equal(address(neighbor.get_creature()[0]), new_body_address)

        # TODO: Figure out how to call a function with just an address.
        #brain = self.state.call(t.k0, new_body_address, 0, "get_brain", "", [])[0]
        #assert_equal(address(brain), t.a1)

    def test_reproduction_notifies_gamemaster(self):
        location = self.state.abi_contract("contracts/square.se")
        neighbor = self.state.abi_contract("contracts/square.se")
        creature_builder = self.state.abi_contract("contracts/creature_builder.se")

        gamemaster = self.state.abi_contract("mocks/gamemaster/spawn_counter.se")

        location.rewrite_state(neighbor.address, 0, 0, 0, 0, self.contract.address, t.a0)
        self.contract.rewrite_state(location.address, 0, 0, 0, 0, gamemaster.address, creature_builder.address)

        gamemaster.send_turn_notification_to(self.contract.address)

        assert_not_equal(self.contract.reproduce_left(t.a1, 0), [0])

        assert_equal(gamemaster.get_spawn_count(), [1])

    def test_can_only_move_on_turn(self):
        location = self.state.abi_contract("contracts/square.se")
        neighbor = self.state.abi_contract("contracts/square.se")

        location.rewrite_state(neighbor.address, 0, 0, 0, 0, self.contract.address, t.a0)
        self.contract.rewrite_state(location.address, 0, 0, 0, 0, t.a0, 0)

        self.contract.move_left()

        assert_equal(address(location.get_creature()[0]), self.contract.address)
        assert_equal(address(self.contract.get_location()[0]), location.address)

        self.contract.notify_of_turn()
        self.contract.move_left()

        assert_equal(address(self.contract.get_location()[0]), neighbor.address)
        assert_equal(location.get_creature(), [0])
        assert_equal(address(neighbor.get_creature()[0]), self.contract.address)
