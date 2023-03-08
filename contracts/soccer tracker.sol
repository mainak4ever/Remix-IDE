pragma solidity >=0.4.22 <=0.8.17;

abstract contract Game {
    // Write your code here
    string homeTeam;
    string awayTeam;

    constructor(string memory _homeTeam, string memory _awayTeam){
        homeTeam=_homeTeam;
        awayTeam=_awayTeam;
    }

    function getHomeTeamScore() internal virtual view returns(uint);

    function getAwayTeamScore() internal virtual view returns(uint);

    function getWinningTeam() public view returns(string memory){
        if(getAwayTeamScore()>getHomeTeamScore()){
            return awayTeam;
        }
        else{
            return homeTeam;
        }
    }
}

contract BasketballGame is Game {
    // Write your code here
    uint256 homeTeamScore;
    uint256 awayTeamScore;

    constructor(string memory _homeTeam, string memory _awayTeam)Game(_homeTeam, _awayTeam){}
    
    modifier validScore(uint score){
        require(score==1 || score==2 || score==3,"Invalid score");
        _;
    }


    function getHomeTeamScore() internal override view returns(uint){
        return homeTeamScore;
    }

    function getAwayTeamScore() internal override view returns(uint){
        return awayTeamScore;
    }

    function homeTeamScored(uint score) external validScore(score){
        homeTeamScore+=score;
    }

    function awayTeamScored(uint score) external validScore(score){
        awayTeamScore+=score;
    }
}

contract SoccerGame is Game {
    // Write your code here
    uint256 homeTeamScore;
    uint256 awayTeamScore;

    constructor(string memory _homeTeam, string memory _awayTeam)Game(_homeTeam, _awayTeam){}

    function getHomeTeamScore() internal override view returns(uint){
        return homeTeamScore;
    }

    function getAwayTeamScore() internal override view returns(uint){
        return awayTeamScore;
    }

    function homeTeamScored() external{
        homeTeamScore++;
    }

    function awayTeamScored() external{
        awayTeamScore++;
    }
}
