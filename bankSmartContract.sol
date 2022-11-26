//Yashvi Mehta BE Comps 2019130037
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BankingSystem{
    mapping(address => uint256) public balance; // To store balances of each account
    uint minimumBalance; //min balance that should be there in any account
    uint noOfBankAccountHolder;
    address payable[] public bankAccountHolders; //address of people who have an account


    constructor(uint _minBalance){ //setting minimum balance amount
        minimumBalance=_minBalance*1 wei;
    }

    function createAccount(uint256 _minDeposit) public { //creating a bank account
        _minDeposit*=1 wei;
        require(_minDeposit>=minimumBalance,"Please deposit minimum amount"); //first deposit should be >= minimum balance 
        balance[msg.sender] = _minDeposit; 
        noOfBankAccountHolder++; //incrementing no of people who have bank accounts
        bankAccountHolders.push(payable(msg.sender));
    }

    function depositAmount() public payable {
        require(balance[msg.sender]!=0, "Please create an account first");  //cannot deposit if account isnt there
        require(msg.value>0,"Please pass an amount");
        balance[msg.sender] += msg.value;
    }

    function withdrawAmount(uint256 amount) public payable { 
        require(balance[msg.sender]!=0, "Please create an account first"); //cannot withdraw if account isnt there
        amount*=1 wei;
        require(amount<= balance[msg.sender] ,"You do not have enough balance to withdraw");
        require((balance[msg.sender] - amount)>=minimumBalance,"You cannot withdraw as your balance would get less than minimum balance");
        balance[msg.sender] -= amount;
        (payable(msg.sender)).transfer(amount);
    }

    function transfer(address payable receiver,uint256 amount) public payable{
        require(balance[msg.sender]!=0, "Please create an account first");  //cannot transfer if account isnt there
        require(balance[receiver]!=0, "The reciever does not have an account");//cannot transfer if reciever does not have a account
        amount*=1 wei;
        require(amount <= balance[msg.sender],"You do not have enough balance to transfer");
        balance[receiver]+=amount;
        balance[msg.sender]-=amount;
        (payable(receiver)).transfer(amount);
    }

    function checkBalance() public view returns (uint256){
        require(balance[msg.sender]!=0, "Please create an account first"); //cannot get balance if account isnt there
        return balance[msg.sender];
    }

}