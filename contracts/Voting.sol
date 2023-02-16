pragma solidity >=0.4.22 <=0.8.17;

contract Voting {
    // Write your code here
    mapping (address => bool) user;
    mapping (uint8 => uint256) votes;
    uint8 currentWinner = 1;

    function getVotes(uint8 number) public view returns(uint){
        require(number>=1 && number<=5," Number not in range");
        return votes[number];
    }

    function vote(uint8 number) public{
        require(number>=1 && number<=5," Number not in range");
        require(!user[msg.sender]," Address already Voted");

        votes[number]+=1;
        user[msg.sender]=true;

        if (votes[number]>= votes[currentWinner]){
            currentWinner=number;
        }
    }

    function getCurrentWinner() public view returns(uint8) {
        return currentWinner;
    }
}

/*
// Copyright © 2023 AlgoExpert LLC. All rights reserved.

pragma solidity >=0.4.22 <=0.8.17;

contract Voting {
    mapping(address => bool) voted;
    mapping(uint8 => uint8) votes;
    uint8 currentWinner;
    uint8 mostVotes;

    function vote(uint8 number) public {
        require(!voted[msg.sender], "address has already voted");
        require(number <= 5 && number >= 1, "number not in range 1-5");

        voted[msg.sender] = true;
        votes[number]++;

        if (votes[number] >= mostVotes) {
            currentWinner = number;
            mostVotes = votes[number];
        }
    }

    function getVotes(uint8 number) public view returns (uint8) {
        require(number <= 5 && number >= 1, "number not in range 1-5");
        return votes[number];
    }

    function getCurrentWinner() public view returns (uint8) {
        if (currentWinner == 0) {
            return 1;
        }

        return currentWinner;
    }
}
*/