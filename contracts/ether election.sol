pragma solidity >=0.4.22 <=0.8.17;

contract EtherElection {
    mapping(address => bool) voters;
    mapping(address => uint8) candidates;
    address[] candidatesArr;
    address winner; 
    bool withdrew;
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function isCandidateInCandidates(address candidate)
        internal
        view
        returns (bool)
    {
        for (uint256 idx; idx < candidatesArr.length; idx++) {
            address currentCandidate = candidatesArr[idx];

            if (currentCandidate == candidate) {
                return true;
            }
        }

        return false;
    }

    function enroll() public payable {
        // Write your code here
        require(candidatesArr.length <3,"Candidates already chosen");
        require(msg.value == 1 ether,"Exactly 1 ether required");
        candidatesArr.push(msg.sender);
    }

    function vote(address candidate) public payable {
        // Write your code here
        require(winner == address(0),"Winner chosen");
        require(isCandidateInCandidates(candidate),"Invalid Candidate");
        require(voters[msg.sender]==false, "Each address can vote once");
        require(msg.value == 10000 wei,"Exactly 10,000 wei required");
        candidates[candidate]++;
        if (candidates[candidate]==5){
            winner = candidate;
        }
    }

    function getWinner() public view returns (address) {
        // Write your code here
        require(winner != address(0)," Winner not chosen yet");
        return winner;
    }

    function claimReward() public {
        // Write your code here
        require(winner != address(0)," Winner not chosen yet");
        require(msg.sender == winner,"You are not the winner");
        (withdrew, ) = payable(msg.sender).call{value: 3 ether}("");
        require(withdrew, "withdraw failed");
    }

    function collectFees() public {
        // Write your code here
        require(msg.sender == owner,"You are not the owner");
        require(withdrew == true," Winner did not claim reward");
        selfdestruct(payable(owner));

    }
}
