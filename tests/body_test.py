from eth_tools import Contract, address
from nose.tools import assert_equal
from pyethereum import tester as t

REWRITE_STATE = 0
MOVE_LEFT = 1
GET_LOCATION = 5
GET_ETHER = 6
GET_HP = 7
GET_BRAIN = 8
HARVEST = 11
ATTACK_LEFT = 13
REPRODUCE_LEFT = 17

SQUARE_REWRITE_STATE = 0
SQUARE_GET_ETHER = 5
SQUARE_GET_CREATURE = 6

class TestBody:
    def setup(self):
        self.state = t.state()
        self.contract = Contract("contracts/body.se", self.state)

    def test_move_left(self):
        location = Contract("contracts/square.se", self.state)
        neighbor = Contract("contracts/square.se", self.state)

        location.call(SQUARE_REWRITE_STATE, [neighbor.contract, 0, 0, 0, 0, self.contract.contract, t.a0])
        assert_equal(address(location.call(SQUARE_GET_CREATURE)[0]), self.contract.contract)

        self.contract.call(REWRITE_STATE, [location.contract, 0, 0, 0, 0, t.a0])
        assert_equal(address(self.contract.call(GET_LOCATION)[0]), location.contract)

        self.contract.call(MOVE_LEFT)

        assert_equal(address(self.contract.call(GET_LOCATION)[0]), neighbor.contract)
        assert_equal(location.call(SQUARE_GET_CREATURE), [0])
        assert_equal(address(neighbor.call(SQUARE_GET_CREATURE)[0]), self.contract.contract)

    def test_harvest(self):
        location = Contract("contracts/square.se", self.state)
        location.call(SQUARE_REWRITE_STATE, [0, 0, 0, 0, 150, self.contract.contract, t.a0])
        self.contract.call(REWRITE_STATE, [location.contract, 0, 0, 0, 0, t.a0])

        assert_equal(location.call(SQUARE_GET_ETHER), [150])
        assert_equal(self.contract.call(GET_ETHER), [0])

        assert_equal(self.contract.call(HARVEST), [100])
        assert_equal(location.call(SQUARE_GET_ETHER), [50])
        assert_equal(self.contract.call(GET_ETHER), [100])

        self.contract.call(HARVEST)
        assert_equal(location.call(SQUARE_GET_ETHER), [0])
        assert_equal(self.contract.call(GET_ETHER), [150])

    def test_attack_left(self):
        location = Contract("contracts/square.se", self.state)
        neighbor = Contract("contracts/square.se", self.state)
        enemy = Contract("contracts/body.se", self.state)

        location.call(SQUARE_REWRITE_STATE, [neighbor.contract, 0, 0, 0, 0, self.contract.contract, t.a0])
        neighbor.call(SQUARE_REWRITE_STATE, [0, location.contract, 0, 0, 0, enemy.contract, t.a0])
        enemy.call(REWRITE_STATE, [neighbor.contract, 0, 3, 0, 0, t.a0])
        self.contract.call(REWRITE_STATE, [location.contract, 0, 0, 0, 0, t.a0])
        assert_equal(enemy.call(GET_HP), [3])

        self.contract.call(ATTACK_LEFT)

        assert_equal(enemy.call(GET_HP), [2])

    def test_reproduce_left(self):
        location = Contract("contracts/square.se", self.state)
        neighbor = Contract("contracts/square.se", self.state)
        creature_builder = Contract("contracts/creature_builder.se", self.state)

        location.call(SQUARE_REWRITE_STATE, [neighbor.contract, 0, 0, 0, 0, self.contract.contract, t.a0])
        self.contract.call(REWRITE_STATE, [location.contract, 0, 0, 0, 0, t.a0, creature_builder.contract])

        assert_equal(neighbor.call(SQUARE_GET_CREATURE), [0])

        new_body_address = address(self.contract.call(REPRODUCE_LEFT, [t.a1, 0])[0])

        assert_equal(address(neighbor.call(SQUARE_GET_CREATURE)[0]), new_body_address)

        new_body = Contract.from_address(new_body_address, self.state)
        assert_equal(address(new_body.call(GET_BRAIN)[0]), t.a1)
