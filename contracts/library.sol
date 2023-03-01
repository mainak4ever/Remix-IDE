pragma solidity ^0.8.12;

//define library
library Mathfunc{

    function myName (int a, int b,int c, int d) public pure returns(int){
        require(b!=0, "Denominator can't be 0");
        return a+b+c+d;
    }
}

contract LibrarySample{
     using Mathfunc for int;
    address owner;
     constructor(){
         owner = msg.sender;
     }

     function div (int a, int b, int c, int d) public payable returns(int){
         require(msg.sender==owner);
         return a.myName(b,c,d);
     }
}