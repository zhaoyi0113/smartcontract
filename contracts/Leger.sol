// SPDX-License-Identifier: MIT
pragma solidity >=0.7.4;
pragma experimental ABIEncoderV2;

contract Ledger {
    mapping(address => uint256) balances;

    address payable owner;

    event Transfered(address _from, address _to, uint256 amount, uint256 fee);

    constructor() payable {
        owner = payable(msg.sender);
        balances[tx.origin] = 10000;
    }

    function sendCoin(address payable receiver)
        public payable
    {
        uint256 amount = msg.value;
        require(balances[msg.sender] >= amount, "out of balance");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        receiver.transfer(amount);
        emit Transfered(msg.sender, receiver, amount, 0);
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }
}
