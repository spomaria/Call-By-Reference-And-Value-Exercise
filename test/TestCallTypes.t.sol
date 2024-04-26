// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { DeployCallTypes } from "../script/DeployCallTypes.s.sol";
import { CallTypes } from "../src/CallTypes.sol";

contract TestCallTypes is Test {
    DeployCallTypes deployer;
    CallTypes callType;
    uint256 private constant MAX_NUMBER = 2^256-1;

    function setUp() public {
        deployer = new DeployCallTypes();
        callType = deployer.run();
    }

    function testContractStoresNewNumber() public{
        // This test demonstrates the use of pointers to carry out
        // 'Call by Reference' in Solidity
        // This is true since the 'setNumber()' function updates the state of the blockchain
        uint256 expectedNumber = 40;
        callType.setNumber(40);
        uint256 actualNumber = callType.getNumber();
        assertEq(expectedNumber, actualNumber);
    }

    function testViewNewNumberDoesNotModifyTheStateOfTheChain() public{
        callType.setNumber(40);
        uint256 expectedNumber = 40;
        uint256 expectedNewNumber = 41;
        
        uint256 actualNewNumber = callType.viewNewNumber();
        uint256 actualNumber = callType.getNumber();
        assertEq(expectedNewNumber, actualNewNumber);
        assertEq(expectedNumber, actualNumber);
    }

    function testFuzz_ViewNewNumberDoesNotModifyTheStateOfTheChain(uint256 num) public{
        callType.setNumber(num);
        uint256 expectedNumber = num;
        uint256 expectedNewNumber = num < MAX_NUMBER ? num + 1 : num;
        
        uint256 actualNewNumber = callType.viewNewNumber();
        uint256 actualNumber = callType.getNumber();
        assertEq(expectedNewNumber, actualNewNumber);
        assertEq(expectedNumber, actualNumber);
    }
}
