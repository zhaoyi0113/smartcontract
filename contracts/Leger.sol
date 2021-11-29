// SPDX-License-Identifier: MIT
pragma solidity >=0.7.4;
pragma experimental ABIEncoderV2;

contract Ledger {
    struct TransferRequest {
        string title;
        uint256 amount;
        string bsb;
        string accountName;
        string accountNumber;
    }

    mapping(address => uint256) balances;

    address payable owner;

    event Transfered(address _from, address _to, uint256 amount);

    constructor() {
        // owner = payable(msg.sender);
        balances[tx.origin] = 10000;
    }

    // function payRequest(address payable _recipient, uint256 _amount)
    //     public
    //     payable
    // {
    //     emit Amount(msg.value);
    //     // require(msg.value == _amount, "Failed");
    //     bool success = _recipient.send(_amount);

    //     emit Transfer(success);

    //     emit RequestPaid(msg.sender, _recipient, _amount);
    // }

    // function transfer(address payable _recipient) public payable {
    //     bool success = _recipient.send(1);
    //     require(success, "Transfer failed.");
    //     emit Transfer(success);
    // }

    // receive() external payable {
    //     emit PaymentReceive(msg.sender, msg.value);
    // }

    // function getBalance() public view returns (uint256) {
    //     return owner.balance;
    // }

    function sendCoin(address receiver, uint256 amount)
        public
        returns (bool sufficient)
    {
        if (balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfered(msg.sender, receiver, amount);
        return true;
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }

    function getBalanceInZellerCoin(address addr)
        public
        view
        returns (uint256)
    {
        return convert(getBalance(addr), 100);
    }

    function convert(uint256 amount, uint256 conversionRate)
        public
        pure
        returns (uint256 convertedAmount)
    {
        return amount * conversionRate;
    }
}
