/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Test, console} from 'forge-std/Test.sol';
import '../src/Types.sol';

contract RequestTest is Test {
    function setUp () public {}

    function test_getHeader () public {
        Header[] memory headers = new Header[](2);
        headers[0] = Header({ key: 'x-api-key', value: '12345' });
        headers[1] = Header({ key: 'x-another', value: 'test' });
        Request memory request = Request({
            method: 'GET',
            uri: '/',
            headers: headers,
            body: ''
        });
        assertEq('test', request.header('x-another'));
    }
}
