pragma solidity >=0.4.22 <=0.8.17;

contract TimedAuction {

    address owner;

    uint expiry;
    uint Highestbid;
    address highestbidder;

    uint8 counter;

    mapping(address=>uint)bids;

    // Declare your event(s) here
    event Bid(address indexed sender, uint256 amount, uint256 timestamp);

    constructor() public {
        owner = msg.sender;
        expiry = block.timestamp + 5 minutes;
    }

    function bid() external payable {
        // Write your code here
        require(block.timestamp < expiry," Time Over");
        require(Highestbid<msg.value,"Highest Bid value is high");

        if(bids[highestbidder]==0){
        bids[highestbidder]+=Highestbid;
        counter++;
        }
        else{
            bids[highestbidder]+=Highestbid;
        }

        Highestbid = msg.value;
        highestbidder= msg.sender;
    }

    function withdraw() public {
        // Write your code here
        require(bids[msg.sender]>0,"User already withdrawn");
        (bool sent,)=payable(msg.sender).call{value : bids[msg.sender]}("");
        require(sent,"withdraw failed");
        bids[msg.sender]=0;
        counter--;
    }

    function claim() public {
        // Write your code here
        require(msg.sender == owner,"You are not the owner");
        require(block.timestamp > expiry," Auction in progress");
        require(counter==0,"Withdrawl not Completed");
        selfdestruct(payable(owner));

    }

    function getHighestBidder() public view returns (address) {
        // Write your code here
        return highestbidder;
    }
}
