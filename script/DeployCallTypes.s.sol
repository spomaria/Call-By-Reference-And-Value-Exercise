// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import { CallTypes } from "../src/CallTypes.sol";

contract DeployCallTypes is Script {
    CallTypes callType;

    function run() public returns(CallTypes) {
        vm.startBroadcast();
        callType = new CallTypes();
        vm.stopBroadcast();
        return callType;
    }
}
