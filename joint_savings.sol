// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0<0.9.0;

/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts- 
a solidity smart contract that 
*   accepts two user addresses that are then able to control a joint savings account. 
*   uses ether management functions to implement various requirements from the financial institution to 
*   provide the features of the joint savings account.
*/

// pragma solidity ^0.5.0;

// Define new contract named `JointSavings`
contract JointSavings {

    // Store addresses of the account owners
    address payable accountOne;
    address payable accountTwo;

    // Keep track of last account to withdraw 'lastToWithdraw', and last amount withdrawn 'lastWithdrawAmount'
    address public lastToWithdraw;
    uint public  lastWithdrawAmount;

    // Keep track of contract's balance 'contractBalance'
    uint public contractBalance;

    /**
     * Allows accountOne and accountTwo to withdraw a specified amount
     * @param amount The amount to be withdrawn
     * @param recipient The address of the account withdrawing
     */
    function withdraw(uint amount, address payable recipient) public {

        // Ensures that the recipient is either accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!3");

        // Ensures that the contract has enough balance for the withdraw operation
        require(address(this).balance >= amount, "Insufficient funds!");

        // Checks if last account to withdraw is different from current recipient
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfers specified amount to recipient
        recipient.transfer(amount);

        // Updates last withdraw amount and contract balance
        lastWithdrawAmount = amount;              // Set  `lastWithdrawAmount` equal to `amount`
        contractBalance = address(this).balance;  // Update the contract balance
    }

    // public payable function to deposit ether into the contract
    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    /**
     * Sets accountOne and accountTwo addresses
     * @param account1 The address of accountOne
     * @param account2 The address of accountTwo
     */
    function setAccounts(address payable account1, address payable account2) public{

        // Set values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    /* function checkValues() view public returns (uint, uint, address){
        return (contractBalance, lastWithdrawAmount, lastToWithdraw);
    } */

    // Fallback function to store ether sent from outside the contract
    function() external payable { }
}
