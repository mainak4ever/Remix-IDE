pragma solidity >=0.4.22 <=0.8.17;

contract RestrictedCount {
    // Write your code here
    address owner;
    int count;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Only owner can call the function");
        _;
    }
    modifier AddRestrict(int value){
        require(count+value<=100);
        require(count+value>=-100);
        _;
    }
    modifier SubRestrict(int value){
        require(count-value<=100);
        require(count-value>=-100);
        _;
    }

    function getCount() public onlyOwner view returns(int256){
        return count;
    }

    function add(int value) public onlyOwner AddRestrict(value){
        count+=value;
    }

    function subtract(int value) public onlyOwner  SubRestrict(value){
        count-=value;
    }
}