/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts- 
a solidity smart contract that 
*   accepts two user addresses that are then able to control a joint savings account. 
*   uses ether management functions to implement various requirements from the financial institution to 
*   provide the features of the joint savings account.
*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Store the addresses of the account owners
    address payable accountOne;
    address payable accountTwo;

    // Keep track of the last account to withdraw, and the amount withdrawn
    address public lastToWithdraw;
    uint public lastWithdrawAmount;

    // Keep track of the contract's balance
    uint public contractBalance;

    // Map to store the allowed addresses
    mapping (address => bool) public allowedAddresses;

    // Function to allow accountOne and accountTwo to withdraw
    function withdraw(uint amount, address payable recipient) public {

        // Ensure that the recipient is one of the account holders
        require(allowedAddresses[recipient], "You don't own this account!");

        // Ensure that the contract has enough balance to complete the withdraw
        require(address(this).balance >= amount, "Insufficient funds!");

        // Update lastToWithdraw and lastWithdrawAmount
        lastToWithdraw = recipient;
        lastWithdrawAmount = amount;

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Update the contract balance
        contractBalance = address(this).balance;
    }

    // public payable function to deposit ether into the contract
    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    // public function to set the account holders
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
        allowedAddresses[account1] = true;
        allowedAddresses[account2] = true;
    }

    // Fallback function to store ether sent from outside the contract
    function() external payable { }
}
