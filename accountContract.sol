// SPDX-License-Identifier: 01234"
pragma solidity ^0.8.0;

contract AccountContract {
    uint public balance;
    address public owner;

    constructor()  {
        owner = msg.sender;
    }

    event Withdraw(address indexed _who, uint256 _amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }


    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
        balance -= address(this).balance;
        emit Withdraw(owner, address(this).balance);
    }

    event Receive(address indexed _who, uint256 _amount);
    event Fallback(address indexed _who, uint256 _amount);

    receive() external payable {
        balance += msg.value;
        emit Receive(msg.sender, msg.value);
    }

    fallback() external payable{
        balance += msg.value;
        emit Fallback(msg.sender, msg.value);
    }
}
