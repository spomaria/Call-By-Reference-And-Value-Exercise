// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract CallTypes {
    uint256 private number;
    uint256 private constant MAX_NUMBER = 2^256-1; // max number for uint256

    function setNumber(uint256 newNumber) public {
        // This function uses call by reference in the sense that
        // 1. the state variable 'number' is passed to this function by reference
        // 2. the 'number' variable in this function is a pointer to the state variable
        //      thus, it can update the state variable
        number = newNumber;
    }

    function viewNewNumber() public view returns(uint256 newNumber) {
        // This function demonstrates call by value in Solidity
        // The 'number' variable in this function is 'called by value'
        // That is why the expression 'number + 1' does not change the
        // value stored by the state variable 'number'
        // only the value of 'number' is passed to the function not its reference
        newNumber = number < MAX_NUMBER ? number + 1 : number; // avoiding overflow
        
        return newNumber;
    }

    function getNumber() public view returns(uint256) {
        return number;
    }
}
