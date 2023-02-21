pragma solidity >=0.4.22 <=0.8.17;

contract EventEmitter {
    // Write your code here
    uint8 Count;
    address sender;

    event Called(uint8 indexed count, address sender);

    function count()public{
        sender=msg.sender;
        Count++;
        emit Called(Count,sender);
    }
}