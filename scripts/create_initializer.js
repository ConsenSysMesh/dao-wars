mineAtLeast(5); // For the reward
personal.unlockAccount(eth.coinbase, "");
transaction = eth.sendTransaction({from: eth.coinbase, gas: 3141592, gasPrice: 1000000000000, data: initializer_data});

mineAtLeast(1);

initializer_address = eth.getTransactionReceipt(transaction).contractAddress;
initializer = eth.contract(initializer_abi).at(initializer_address);
