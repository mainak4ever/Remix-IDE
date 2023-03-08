pragma solidity >=0.4.22 <=0.8.17;

contract Friends {
    // Write your code here
    mapping(address => friendlist)user;

    struct friendlist{
        address[] friends;
        address[] friendrequests;
    }

    function arrayContains(address[] memory array, address target)
        internal
        pure
        returns (bool)
    {
        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                return true;
            }
        }
        return false;
    }

    function deleteFromArray(address[] storage array, address target) internal {
        uint256 targetIdx;
        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                targetIdx = idx;
                break;
            }
        }

        uint256 lastIdx = array.length - 1;
        address lastValue = array[lastIdx];
        array[lastIdx] = target;
        array[targetIdx] = lastValue;
        array.pop();
    }

    modifier checkRequestSent(address friend){
        address[] memory requestsSent = user[friend].friendrequests;
        require(!arrayContains(requestsSent,msg.sender),"You have already sent request");
        _;
    }

    modifier checkRequestReceived(address friend){
        address[] memory requestsReceived = user[msg.sender].friendrequests;
        require(!arrayContains(requestsReceived,friend),"You have already sent request");
        _;
    }

    modifier checkfriends(address friend){
        address[] memory _friends = user[friend].friends;
        require(!arrayContains(_friends,friend),"You have already sent request");
        _;
    }

    modifier notSelf(address friend) {
        require(
            friend != msg.sender,
            "you cannot send a friend request to yourself"
        );
        _;
    }

     modifier checkRequest(address friend){
        address[] memory requestsReceived = user[msg.sender].friendrequests;
        require(arrayContains(requestsReceived,friend),"user has not sent request");
        _;
    }



    function getFriendRequests()public view returns(address[] memory){
        return user[msg.sender].friendrequests;
    }

    function getNumberOfFriends() public view returns(uint){
        return user[msg.sender].friends.length;
    }

    function getFriends() public view returns(address[] memory){
        return user[msg.sender].friends;
    }

    function sendFriendRequest(address friend) public
        checkRequestSent(friend)
        checkRequestReceived(friend)
        checkfriends(friend)
        notSelf(friend)
    {
        user[friend].friendrequests.push(msg.sender);
    }

    function acceptFriendRequest(address friend)public 
        checkRequest(friend)
    {
        deleteFromArray(user[msg.sender].friendrequests,friend);
        user[msg.sender].friends.push(friend);
        user[friend].friends.push(msg.sender);
    }
}
