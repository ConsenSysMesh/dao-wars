"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var BrainMock = (function (_Pudding) {
    _inherits(BrainMock, _Pudding);

    function BrainMock() {
      _classCallCheck(this, BrainMock);

      _get(Object.getPrototypeOf(BrainMock.prototype), "constructor", this).apply(this, arguments);
    }

    return BrainMock;
  })(Pudding);

  ;

  // Set up specific data for this class.
  BrainMock.abi = [{ "constant": false, "inputs": [], "name": "ping", "outputs": [], "type": "function" }, { "constant": true, "inputs": [], "name": "times_called", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [], "name": "reset", "outputs": [], "type": "function" }];
  BrainMock.binary = "606060405260be8060106000396000f3606060405260e060020a60003504635c36b1868114602e578063af8473a81460a4578063d826f88f1460ac575b005b600080547f70e87aaf000000000000000000000000000000000000000000000000000000006060908152600490910660ff16606452602c913373ffffffffffffffffffffffffffffffffffffffff16916370e87aaf9160849160248183876161da5a03f115600257505060008054600101905550565b60b460005481565b602c60008055565b6060908152602090f3";

  if ("0x9026ba40f8e165ead2c7a348273abe19403e4bb0" != "") {
    BrainMock.address = "0x9026ba40f8e165ead2c7a348273abe19403e4bb0";

    // Backward compatibility; Deprecated.
    BrainMock.deployed_address = "0x9026ba40f8e165ead2c7a348273abe19403e4bb0";
  }

  BrainMock.generated_with = "1.0.2";
  BrainMock.contract_name = "BrainMock";

  return BrainMock;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.BrainMock = factory;
}