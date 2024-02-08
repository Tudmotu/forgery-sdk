/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import {Script, console} from 'forge-std/Script.sol';
import './Types.sol';

struct Router {
    mapping(
        string route => function (Request calldata)
    ) GET;
    mapping(
        string route => function (Request calldata)
    ) POST;
    mapping(
        string route => function (Request calldata)
    ) PUT;
    mapping(
        string route => function (Request calldata)
    ) PATCH;
    mapping(
        string route => function (Request calldata)
    ) DELETE;
}

using RouterImpl for Router global;

library RouterImpl {
    function get (
        Router storage self,
        string memory path,
        function (Request calldata) callback
    ) internal {
        self.GET[path] = callback;
    }

    function post (
        Router storage self,
        string memory path,
        function (Request calldata) callback
    ) internal {
        self.POST[path] = callback;
    }

    function put (
        Router storage self,
        string memory path,
        function (Request calldata) callback
    ) internal {
        self.PUT[path] = callback;
    }

    function patch (
        Router storage self,
        string memory path,
        function (Request calldata) callback
    ) internal {
        self.PATCH[path] = callback;
    }

    function del (
        Router storage self,
        string memory path,
        function (Request calldata) callback
    ) internal {
        self.DELETE[path] = callback;
    }
}
