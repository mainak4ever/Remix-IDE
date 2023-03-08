pragma solidity >=0.4.22 <=0.8.17;

library Array {
    // Write your code here
    function indexOf(int[] memory numbers, int target)public pure returns(int){
        for (uint i; i < numbers.length; i++){
            if (numbers[i]==target){
                return int(i);
            }   
        }
        return -1;
    }

    function count(int[] memory numbers, int target)public pure returns(uint){
        uint arraycount;
        for (uint i; i < numbers.length; i++){
            if (numbers[i]==target){
                arraycount++;
            }
        }
        return arraycount;
    }

    function sum(int[] memory numbers)public pure returns(int){
        int arrsum;
        for (uint i; i < numbers.length; i++){
                arrsum+=numbers[i];
        }
        return arrsum;
    }
}
