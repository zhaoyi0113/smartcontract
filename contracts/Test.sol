// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.4;
pragma experimental ABIEncoderV2;

contract Test {
    struct TransferRequest {
        string title;
        uint256 amount;
        string bsb;
        string accountName;
        string accountNumber;
    }

    address payable owner;

    event PaymentReceive(address from, uint256 amount);
    event Transfered(bool success, bytes transactionBytes);
    event Transfer(bool success);
    event Amount(uint256 amount);

    event RequestPaid(address sender, address recipient, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    function payRequest(address payable _recipient, uint256 _amount) public payable{
        emit Amount(msg.value);
        // require(msg.value == _amount, "Failed");
        _recipient.transfer(_amount);
        
        emit Transfer(true);
        
        emit RequestPaid(msg.sender, _recipient, _amount);
    }

    function transfer(address payable _recipient) public payable {
        
        bool success = _recipient.send(1);
        require(success, "Transfer failed.");
        emit Transfer(success);
    }

    receive() external payable {
        emit PaymentReceive(msg.sender, msg.value);
    }


    function getBalance() public view returns (uint256) {
        return owner.balance;
    }
    

}
