from solidity_compiler import compile_solidity
from pyethereum import tester as t

class Contract(object):
    def __init__(self, filepath):
        self.code = compile_solidity(filepath)
        self.state = t.state()
        self.contract = self.state.evm(self.code)

    def call(self, function, arguments, ether=0):
        return self.state.send(t.k0, self.contract, ether, funid=function, abi=arguments)
