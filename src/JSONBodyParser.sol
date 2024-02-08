/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {console} from 'forge-std/Script.sol';
import './Types.sol';
import './Constants.sol';

struct JSONItem {
    string json;
    string path;
}

using JSONItemImpl for JSONItem global;

library JSONItemImpl {
    function at (
        JSONItem memory self,
        string memory key
    ) pure public returns (JSONItem memory item) {
        item.path = string.concat(self.path, '.', key);
        item.json = self.json;
    }

    function at (
        JSONItem memory self,
        uint index
    ) pure public returns (JSONItem memory item) {
        item.path = string.concat(self.path, '[', vm.toString(index), ']');
        item.json = self.json;
    }

    function asString (
        JSONItem memory self
    ) pure public returns (string memory value) {
        value = vm.parseJsonString(self.json, self.path);
    }

    function asUint (
        JSONItem memory self
    ) pure public returns (uint value) {
        value = vm.parseJsonUint(self.json, self.path);
    }

    function asInt (
        JSONItem memory self
    ) pure public returns (int value) {
        value = vm.parseJsonInt(self.json, self.path);
    }

    function asAddress (
        JSONItem memory self
    ) pure public returns (address value) {
        value = vm.parseJsonAddress(self.json, self.path);
    }

    function asBytes (
        JSONItem memory self
    ) pure public returns (bytes memory value) {
        value = vm.parseJsonBytes(self.json, self.path);
    }

    function asStringArray (
        JSONItem memory self
    ) pure public returns (string[] memory value) {
        value = vm.parseJsonStringArray(self.json, self.path);
    }

    function asUintArray (
        JSONItem memory self
    ) pure public returns (uint[] memory value) {
        value = vm.parseJsonUintArray(self.json, self.path);
    }

    function asIntArray (
        JSONItem memory self
    ) pure public returns (int[] memory value) {
        value = vm.parseJsonIntArray(self.json, self.path);
    }

    function asAddressArray (
        JSONItem memory self
    ) pure public returns (address[] memory value) {
        value = vm.parseJsonAddressArray(self.json, self.path);
    }

    function asBytesArray (
        JSONItem memory self
    ) pure public returns (bytes[] memory value) {
        value = vm.parseJsonBytesArray(self.json, self.path);
    }
}

library JSONBodyParser {
    function json (
        Request calldata self
    ) pure public returns (JSONItem memory item) {
        item = JSONItem(string(self.body), '');
    }
}
