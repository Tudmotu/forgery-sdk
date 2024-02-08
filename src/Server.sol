/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Script, console} from 'forge-std/Script.sol';
import './Types.sol';
import './Router.sol';

abstract contract Server is Script {
    Router router;
    Response response;

    function serve (
        Request calldata request
    ) external returns (Response memory res) {
        string calldata method = request.method;

        if (keccak256(bytes(method)) == keccak256(bytes('GET'))) {
            router.GET[request.uri](request);
        }
        else if (keccak256(bytes(method)) == keccak256(bytes('POST'))) {
            router.POST[request.uri](request);
        }
        else if (keccak256(bytes(method)) == keccak256(bytes('PUT'))) {
            router.PUT[request.uri](request);
        }
        else if (keccak256(bytes(method)) == keccak256(bytes('PATCH'))) {
            router.PATCH[request.uri](request);
        }
        else if (keccak256(bytes(method)) == keccak256(bytes('DELETE'))) {
            router.DELETE[request.uri](request);
        }

        Header[] memory headers = new Header[](response.headers.length);
        for (uint i = 0; i < headers.length; i++) {
            headers[i] = response.headers[i];
        }

        res = Response({
            status: response.status,
            headers: headers,
            body: response.body
        });
        
        emptyResponse();
    }

    function emptyResponse () internal {
        response.status = 0;
        response.body = hex'';
        while (response.headers.length > 0) {
            response.headers.pop();
        }
    }

    function start () external virtual;
}
