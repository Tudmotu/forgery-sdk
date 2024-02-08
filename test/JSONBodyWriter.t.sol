/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Test, console} from 'forge-std/Test.sol';
import '../src/Types.sol';
import '../src/JSONBodyWriter.sol';

contract JSONBodyWriterTest is Test {
    using JSONBodyWriter for Response;

    Response response;

    function setUp () public {
        response.status = 0;
        response.body = hex'';
        while (response.headers.length > 0) {
            response.headers.pop();
        }
    }

    function test_writeObject () public {
        address[] memory tokens = new address[](2);
        tokens[0] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        tokens[1] = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        response.write('tokens', tokens);

        string memory userObject = vm.serializeAddress('user', 'address', 0x61880628e88b391C0161225887D65087EF5bD19B);
        userObject = vm.serializeString('user', 'ens', 'dog.eth');
        response.write('user', userObject);

        assertEq(
            string(response.body),
            '{"tokens":["0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48","0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"],"user":{"address":"0x61880628e88b391C0161225887D65087EF5bD19B","ens":"dog.eth"}}'
        );

    }

    function test_writeKeyStringArray () public {
        string[] memory arr = new string[](2);
        arr[0] = 'hello';
        arr[1] = 'world';
        response.write('name', arr);
        assertEq(string(response.body), '{"name":["hello","world"]}');
    }

    function test_writeKeyAddressArray () public {
        address[] memory arr = new address[](2);
        arr[0] = address(0);
        arr[1] = address(0xEe87F4a569dF482D884863d49a33F59f1fD49983);
        response.write('name', arr);
        assertEq(
            string(response.body),
            '{"name":["0x0000000000000000000000000000000000000000","0xEe87F4a569dF482D884863d49a33F59f1fD49983"]}'
        );
    }

    function test_writeKeyUintArray () public {
        uint[] memory arr = new uint[](2);
        arr[0] = 1337;
        arr[1] = 777;
        response.write('name', arr);
        assertEq(string(response.body), '{"name":[1337,777]}');
    }

    function test_writeKeyIntArray () public {
        int[] memory arr = new int[](2);
        arr[0] = 69;
        arr[1] = -420;
        response.write('name', arr);
        assertEq(string(response.body), '{"name":[69,-420]}');
    }

    function test_writeKeyBytesArray () public {
        bytes[] memory arr = new bytes[](2);
        arr[0] = hex'c0ffee';
        arr[1] = hex'beef';
        response.write('name', arr);
        assertEq(string(response.body), '{"name":["0xc0ffee","0xbeef"]}');
    }

    function test_writeKeyStringValue () public {
        response.write('name', 'testing');
        assertEq(string(response.body), '{"name":"testing"}');
    }

    function test_writeKeyAddressValue () public {
        response.write('name', address(0xEe87F4a569dF482D884863d49a33F59f1fD49983));
        assertEq(string(response.body), '{"name":"0xEe87F4a569dF482D884863d49a33F59f1fD49983"}');
    }

    function test_writeKeyUintValue () public {
        response.write('name', 123);
        assertEq(string(response.body), '{"name":123}');
    }

    function test_writeKeyIntValue () public {
        response.writeInt('name', -69);
        assertEq(string(response.body), '{"name":-69}');
    }

    function test_writeKeyBytesValue () public {
        response.writeBytes('name', hex'beef');
        assertEq(string(response.body), '{"name":"0xbeef"}');
    }
}
