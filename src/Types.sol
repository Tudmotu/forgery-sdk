/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import './Constants.sol';

// Http trigger types
struct Header {
    string key;
    string value;
}

struct Request {
    string method;
    string uri;
    Header[] headers;
    bytes body;
}

struct Response {
    uint16 status;
    Header[] headers;
    bytes body;
}

using ResponseImpl for Response global;

library ResponseImpl {
    function header (
        Response storage self,
        string memory key,
        string memory value
    ) public {
        self.headers.push(Header({ key: key, value: value }));
    }
}

using RequestImpl for Request global;

library RequestImpl {
    function header (
        Request calldata self,
        string memory key
    ) pure public returns (string memory value) {
        for (uint i = 0; i < self.headers.length; i++) {
            if (keccak256(bytes(self.headers[i].key)) == keccak256(bytes(key))) {
                return self.headers[i].value;
            }
        }
    }
}

// Log trigger types
struct EvmLog {
    address emitter;
    bytes[] topics;
    bytes data;
    bytes blockHash;
    uint blockNumber;
    bytes txHash;
    uint txIndex;
    uint logIndex;
    bool removed;
}
