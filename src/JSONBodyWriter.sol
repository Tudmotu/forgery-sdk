/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {console} from 'forge-std/Script.sol';
import 'forge-std/StdJson.sol';
import './Constants.sol';
import './Types.sol';

string constant RESPONSE_JSON = '$__forgery-response__$';

library JSONBodyWriter {
    function write (
        Response storage self,
        string memory key,
        string[] memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        address[] memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        uint[] memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        int[] memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        bytes[] memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        string memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        address value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function write (
        Response storage self,
        string memory key,
        uint value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function writeInt (
        Response storage self,
        string memory key,
        int value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }

    function writeBytes (
        Response storage self,
        string memory key,
        bytes memory value
    ) public {
        self.body = bytes(stdJson.serialize(RESPONSE_JSON, key, value));
    }
}
