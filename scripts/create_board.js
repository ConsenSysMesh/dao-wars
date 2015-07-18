loadScript('helpers.js')
loadScript('abi.js')
loadScript('board_data.js')

personal.unlockAccount(eth.coinbase, "");
mineAtLeast(2);
transaction = eth.sendTransaction({from: eth.coinbase, gas: 3141592, gasPrice: 1000000000000, data: board_data});

mineAtLeast(1);

board_address = eth.getTransactionReceipt(transaction).contractAddress;
board = eth.contract(boardAbi).at(board_address);
