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

    event Transfered(bool _success, address _from, address _to, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
        balances[tx.origin] = 10000;
    }

    function sendCoin(address payable receiver)
        public payable
    {
        require(msg.sender == owner);
        uint256 amount = msg.value;
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        receiver.transfer(amount);
        emit Transfered(true, msg.sender, receiver, amount);
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }

    function convert(uint256 amount, uint256 conversionRate)
        public
        pure
        returns (uint256 convertedAmount)
    {
        return amount * conversionRate;
    }

    function getBalanceInZellerCoin(address addr)
        public
        view
        returns (uint256)
    {
        return convert(getBalance(addr), 100);
    }

}
