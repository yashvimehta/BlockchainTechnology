//Yashvi Mehta BE Comps 2019130037
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Yashvi{

    uint limit=10000;
    uint food;
    uint transport;
    uint stay;
    uint balance;

    function getExpenses(uint _food, uint _transport, uint _stay) public {
        food = _food;
        transport = _transport;
        stay = _stay;
    }
    function returnBalance() public view returns (uint){
        return limit-(food+transport+stay);
    }
}
