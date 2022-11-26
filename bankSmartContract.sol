//Yashvi Mehta BE Comps 2019130037
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BankingSystem{
    mapping(address => uint256) public balance; // To store balances of each account
    mapping(address => uint256) public savingBalance; // To store balances of savings account
    mapping(address => uint256) public savingInterest; // To store interest of savings account
    uint minimumBalance; //min balance that should be there in any account
    uint noOfBankAccountHolder;
    uint rate;
    address payable[] public bankAccountHolders; //address of people who have an account
    address manager;// To store managers address

    constructor(uint _minBalance, uint _rate){ //setting minimum balance amount
        minimumBalance=_minBalance*1 wei;
        rate = _rate;
    }

    modifier onlyManager(){
        //Modifier to enable functions that can only be viewed ny manager
        require(msg.sender==manager,"Only manager can access this function");
        _;
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

    function checkNoOfBankAccountHolder()public onlyManager view returns(uint){
        return noOfBankAccountHolder; //only manager can access
    }

    function createSavingsAccount (uint _amount, uint _years)public {
        _amount*=1 wei;
        require(balance[msg.sender]!=0, "Please create an account first"); //cannot create savings account if abank ccount isnt there
        require(_amount < balance[msg.sender], "You dont have enough balance to create savings account");
        require((balance[msg.sender] - _amount)>=minimumBalance, "You cannot create savings account");
        savingInterest[msg.sender] =( _amount * rate * _years)/100;
        savingBalance[msg.sender] = _amount; 
    }

    function getSavingInterest()public view returns(uint){
        require(savingBalance[msg.sender]!=0, "Please create an account first"); //cannot create savings account if abank ccount isnt there
        return savingInterest[msg.sender];
    }

}