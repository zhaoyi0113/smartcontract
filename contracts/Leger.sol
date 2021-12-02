// SPDX-License-Identifier: MIT
pragma solidity >=0.7.4;
pragma experimental ABIEncoderV2;

import "prb-math/contracts/PRBMathUD60x18.sol";


contract Ledger {
    using PRBMathUD60x18 for uint256;

    mapping(address => uint256) balances;

    address payable owner;

    event Transfered(address _from, address _to, uint256 amount, uint256 fee);

    modifier hasEnoughBalance {
        require(balances[msg.sender] >= msg.value, "out of balance");
        _;
    }

    function unsignedDivision(uint256 x, uint256 y) external pure returns (uint256 result) {
        result = x.div(y);
    }
    
    function fromUint(uint256 x) external pure returns (uint256 result) {
        result = x.fromUint();
    }

    function toUint(uint256 x) external pure returns (uint256 result) {
        result = x.toUint();
    }

    constructor() payable {
        owner = payable(msg.sender);

        uint256 startingAmount = 10000;
        balances[tx.origin] = startingAmount.fromUint();
    }

    function sendCoin(address payable receiver)
        public
        payable
        hasEnoughBalance
    {
        uint256 amount = this.fromUint(msg.value);
        uint256 feeRate = this.fromUint(100);

        balances[msg.sender] -= amount;
        uint256 fee = this.unsignedDivision(amount, feeRate);

        balances[receiver] += amount - fee;
        receiver.transfer(msg.value);
        emit Transfered(msg.sender, receiver, msg.value, fee);
    }


    function getBalance(address addr) public view returns (uint256) {
        return this.toUint(balances[addr]);
    }
}
