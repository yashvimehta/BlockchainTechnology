//Yashvi Mehta 2019130037 BE Comps 

// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract YashviFrontEnd{

    string name;
    string email;
    string password;
    string college;
    uint rollNo;

    function set(string memory _name, string memory _email, string memory _password,  string memory _college, uint _rollNo) public{
        name = _name;
        email = _email;
        password = _password;
        college = _college;
        rollNo = _rollNo;
    }

    function get() view public returns(string memory,string memory,string memory,string memory,uint){
        return(name,email,college,password,rollNo);
    }
}