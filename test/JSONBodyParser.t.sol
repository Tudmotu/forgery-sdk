/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Test, console} from 'forge-std/Test.sol';
import '../src/Types.sol';
import '../src/JSONBodyParser.sol';

contract JSONBodyParserTest is Test {
    using JSONBodyParser for Request;

    function setUp () public { }

    function test_getStringArray () public {
        Request memory req;
        req.body = bytes('{ "arr": ["0x1cec0fee", "0xbadf100d"] }');
        string[] memory arr = req.json().at('arr').asStringArray();
        assertEq(arr[0], '0x1cec0fee');
        assertEq(arr[1], '0xbadf100d');
    }

    function test_getUintArray () public {
        Request memory req;
        req.body = bytes('{ "arr": [69, 420] }');
        uint[] memory arr = req.json().at('arr').asUintArray();
        assertEq(arr[0], 69);
        assertEq(arr[1], 420);
    }

    function test_getIntArray () public {
        Request memory req;
        req.body = bytes('{ "arr": [-69, 420] }');
        int[] memory arr = req.json().at('arr').asIntArray();
        assertEq(arr[0], -69);
        assertEq(arr[1], 420);
    }

    function test_getAddressArray () public {
        Request memory req;
        req.body = bytes('{\
            "arr": [\
                "0xEe87F4a569dF482D884863d49a33F59f1fD49983",\
                "0xBAac2B4491727D78D2b78815144570b9f2Fe8899"\
            ]\
        }');
        address[] memory arr = req.json().at('arr').asAddressArray();
        assertEq(arr[0], address(0xEe87F4a569dF482D884863d49a33F59f1fD49983));
        assertEq(arr[1], address(0xBAac2B4491727D78D2b78815144570b9f2Fe8899));
    }

    function test_getBytesArray () public {
        Request memory req;
        req.body = bytes('{ "arr": ["0x1cec0fee", "0xbadf100d"] }');
        bytes[] memory arr = req.json().at('arr').asBytesArray();
        assertEq(arr[0], hex'1cec0fee');
        assertEq(arr[1], hex'badf100d');
    }

    function test_getArrayItem () public {
        Request memory req;
        req.body = bytes('{ "arr": ["0x1cec0fee", "0xbadf100d"] }');
        assertEq(
            hex'badf100d',
            req.json().at('arr').at(1).asBytes()
        );
    }

    function test_getArrayElementKey () public {
        Request memory req;
        req.body = bytes('[{ "key": "0x1cec0fee" }]');
        assertEq(
            hex'1cec0fee',
            req.json().at(0).at('key').asBytes()
        );
    }

    function test_getKeyBytesValue () public {
        Request memory req;
        req.body = bytes('{ "key": "0x1cec0fee" }');
        assertEq(
            hex'1cec0fee',
            req.json().at('key').asBytes()
        );
    }

    function test_getKeyAddressValue () public {
        Request memory req;
        req.body = bytes('{ "key": "0xEe87F4a569dF482D884863d49a33F59f1fD49983" }');
        assertEq(
            address(0xEe87F4a569dF482D884863d49a33F59f1fD49983),
            req.json().at('key').asAddress()
        );
    }

    function test_getKeyIntValue () public {
        Request memory req;
        req.body = bytes('{ "key": -12345 }');
        assertEq(-12345, req.json().at('key').asInt());
    }

    function test_getKeyUintValue () public {
        Request memory req;
        req.body = bytes('{ "key": 12345 }');
        assertEq(12345, req.json().at('key').asUint());
    }

    function test_getKeyStringValue () public {
        Request memory req;
        req.body = bytes('{ "key": "test" }');
        assertEq('test', req.json().at('key').asString());
    }
}
