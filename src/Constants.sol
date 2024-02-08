/// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.24;

import 'forge-std/Vm.sol';
import {console} from 'forge-std/Script.sol';

Vm constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));
