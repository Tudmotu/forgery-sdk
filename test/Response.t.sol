/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Test, console} from 'forge-std/Test.sol';
import '../src/Types.sol';

contract ResponseTest is Test {
    Response response;

    function setUp () public {
        response.status = 0;
        response.body = hex'';
        while (response.headers.length > 0) {
            response.headers.pop();
        }
    }

    function test_addTwoHeaders () public {
        response.header('content-type', 'text/plain');
        response.header('access-control-allow-origin', '*');
        assertEq('content-type', response.headers[0].key);
        assertEq('text/plain', response.headers[0].value);
        assertEq('access-control-allow-origin', response.headers[1].key);
        assertEq('*', response.headers[1].value);
    }

    function test_addHeader () public {
        response.header('content-type', 'application/json');
        assertEq('content-type', response.headers[0].key);
        assertEq('application/json', response.headers[0].value);
    }
}
