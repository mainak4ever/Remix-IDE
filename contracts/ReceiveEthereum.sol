pragma solidity >=0.4.22 <=0.8.17;

contract Balances {
    // Write your code 
    mapping (address => uint) Balances;

    receive() external payable{
        Balances[msg.sender]+=msg.value;
    }

    fallback() external payable{
        Balances[msg.sender]+=msg.value;
    }

    function getAmountSent(address addr) public view returns(uint256){
        return Balances[addr];
    }
}
