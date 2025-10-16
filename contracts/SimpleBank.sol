//SPDX-License=Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleBank {
    //State Variables
    mapping(address => uint256) private balances;
    address public owner;
    uint256 public totalDeposits;


    //Events
    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can call this function");
        _;
    }

    constructor() {
       owner = msg.sender; 
    }

    function deposit() external payable {
        require(msg.value > 0, "Invalid amount");

        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;

        emit Deposit(msg.sender, msg.value);
    }


   function withdraw(uint256 amount) external {
    require(amount > 0, "Invalid withdraw amount");
    require(balances[msg.sender] >= amount, "Insufficient balance");

    balances[msg.sender] -= amount;

    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");

    emit Withdraw(msg.sender, amount);
}


function getBalance(address account) external view returns (uint256) {
    return balances[msg.sender];
}

function getContractBalance() external view returns(uint256) {
    return address(this).balance;
}


function emergencyWithdraw() external onlyOwner(){
    uint256 contractBalance = address(this).balance;
    require(contractBalance > 0, "No funds to withdraw");

    (bool success,) = payable(owner).call{value: contractBalance}("");
    require(success, "Emergency withdrawal failed");
}



}