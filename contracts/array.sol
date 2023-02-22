pragma solidity >=0.4.22 <=0.8.17;

contract Following {
    // Write your code here
    mapping (address => address[3] ) addresses;

    function follow (address toFollow) public {
        require(addresses[msg.sender][2]!=address(0),"All space taken");
        require(msg.sender!=toFollow,"Cant follow own address");

        if (addresses[msg.sender][0]==address(0)){
            addresses[msg.sender][0]=toFollow;
        }
        else if (addresses[msg.sender][1]==address(0)){
            addresses[msg.sender][1]=toFollow;
        }
        else{
            addresses[msg.sender][2]=toFollow;
        }
    }

    function getFollowing(address addr)public returns(address[3] memory){
        return addresses[addr];
    }

    function clearFollowing() public{
        delete addresses[msg.sender];
    }
}
