pragma solidity ^0.8.0;

contract Election {

    address Owner;
    constructor(address _owner){
        Owner = _owner;
    }


    struct Candidate {
        uint id;
        string name;
        string proposal;
        uint voteCount;
    }

    Candidate[] candidates;

    function addCandidate(string memory _name, string memory _proposal, address owner) public {
        require(msg.sender == Owner, "Only the owner can add a candidate");

        uint id = candidates.length + 1;
        candidates.push(Candidate(id, _name, _proposal, 0));
    }


    struct Voter{
        uint id;
        address Address;
        address delegate;
        uint CandidateVoted;
    }

    Voter[] Voters;
    mapping(address => uint) voters;


    function addVoter(address _voter, address owner) public {
        require(msg.sender == Owner, "Only the owner can add a voter");
        require(voters[_voter]== 0, "Voter already exists");

        uint id = Voters.length + 1;
        voters[_voter] = id;
        Voters.push(Voter(id,_voter,address(0),0));

    }


    enum ElectionState { NOT_STARTED, ONGOING, ENDED }

    ElectionState state;

    function startElection(address owner) public {
        require(msg.sender == Owner, "Only the owner can start the election");
        require(state == ElectionState.NOT_STARTED, "Election already started");

        state = ElectionState.ONGOING;
    }

    function getCandidate(uint _id) public view returns (uint, string memory, string memory, uint) {
        require(_id > 0 && _id <= candidates.length, "Invalid candidate ID");

        Candidate memory candidate = candidates[_id - 1];
        return (candidate.id, candidate.name, candidate.proposal, candidate.voteCount);
    }

    function getWinner() public view returns (string memory, uint, uint) {
        require(state == ElectionState.ENDED, "Election not ended yet");

        uint maxVoteCount = 0;
        uint winnerId;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVoteCount) {
                maxVoteCount = candidates[i].voteCount;
                winnerId = candidates[i].id;
            }
        }

        Candidate memory winner = candidates[winnerId - 1];
        return (winner.name, winner.id, winner.voteCount);

    }
    
    mapping(address => address) delegates;

    function delegate(address _to, address _voter) public {
        require(msg.sender==_voter,"Only voter can delegate");
        require(state == ElectionState.ONGOING, "Election not ongoing");
        require(voters[msg.sender]!=0, "Sender is not a registered voter");
        require(msg.sender != _to, "Cannot delegate to yourself");

        uint id = voters[_voter];
        uint index = id - 1;
        Voters[index].delegate = _to;

        delegates[_to] = _voter;

    }

    mapping (address => bool) voted;

    function vote(uint candidateId, address voterAddress) public {  
        require(state == ElectionState.ONGOING, "Election not ongoing");
        require(msg.sender == voterAddress, "you are not the voter");
        require(!voted[voterAddress], "Voter has already voted");
        require(candidateId > 0 && candidateId <= candidates.length, "Invalid candidate ID");

        if (delegates[voterAddress]==address(0)){
            candidates[candidateId-1].voteCount++;
            voted[voterAddress]=true;
            Voters[voters[voterAddress]-1].CandidateVoted = candidateId;
        }
        else {
            address v_Address = delegates[voterAddress];
            candidates[candidateId-1].voteCount++;
            voted[v_Address]=true;
            Voters[voters[v_Address]-1].CandidateVoted = candidateId;
        }
    }

    function endElection(address owner) public {
        require(msg.sender == Owner,"Only owner can end election");
        require(state == ElectionState.ONGOING, "Election not ongoing");

        state = ElectionState.ENDED;
    }

    function getCandidateVotes(uint candidateId) public view returns (uint) {
        require(candidateId > 0 && candidateId <= candidates.length, "Invalid candidate ID");

        return candidates[candidateId-1].voteCount;
    }

    function getVoterProfile(address voterAddress) public view returns (uint, address, bool,uint) {
        require(voters[voterAddress]!= 0, "Voter does not exists");
        require(msg.sender == voterAddress,"Only voter can see the details");

        Voter memory voter = Voters[voters[voterAddress]-1];
        bool delegated;
        if (voter.delegate == address(0)){
            delegated = false;
        }
        else {
            delegated = true;
        }

        return (voter.id,voter.delegate,delegated,voter.CandidateVoted);
    }

}