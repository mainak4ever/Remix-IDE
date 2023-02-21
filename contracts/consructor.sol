pragma solidity >=0.4.22 <=0.8.17;

contract OnlyOwner {
    // Write your code here
    address owner;
    uint8 num;

    constructor(){
        owner = msg.sender;
    }

    function add(uint8 number)public{
        require(msg.sender==owner, "You are not the owner");
        num+=number;
    }

    function subtract(uint8 number)public{
        require(msg.sender==owner, "You are not the owner");
        num-=number;
    }

    function get()public view returns(uint8){
        require(msg.sender==owner, "You are not the owner");
        return num;
    }
}
