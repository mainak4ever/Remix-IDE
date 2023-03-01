pragma solidity >=0.4.22 <=0.8.17;

contract FizzBuzz {
    uint count ;

    event Fizz (address sender, uint indexed count);
    event Buzz (address sender, uint indexed count);
    event FizzAndBuzz(address sender, uint indexed count);

    function increment() public {
        // Write your code here
        count++;
        
        bool divisibleBy3 = count % 3 == 0;
        bool divisibleBy5 = count % 5 == 0;

        if (divisibleBy3 && divisibleBy5) {
            emit FizzAndBuzz(msg.sender, count);
        } else if (divisibleBy3) {
            emit Fizz(msg.sender, count);
        } else if (divisibleBy5) {
            emit Buzz(msg.sender, count);
        }
    }
}