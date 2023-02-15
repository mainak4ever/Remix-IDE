pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
    // Write your code here
    mapping (address => uint256) pendingWithdrawls;
    address richest;
    uint mostsent;

    function becomeRichest() external payable returns(bool) {
        if(msg.value > mostsent){
            pendingWithdrawls[richest] += mostsent;
            richest = msg.sender;
            mostsent = msg.value;
            return true;
        }
        return false;
    }

    function withdraw() external {
        uint value = pendingWithdrawls[msg.sender];
        pendingWithdrawls[msg.sender]=0;
        payable(msg.sender).transfer(value);
    }

    function getRichest() public view returns(address){
        return richest;
    }
}

/*contract Richest {
    // Write your code here
    mapping (address => uint256) users;
    //mapping (address => uint256) pendingWithdrawls;
    address richest;
    address preRichest;

    function becomeRichest() external payable returns(bool) {
        users[msg.sender]+=msg.value;
        if (users[msg.sender]> users[richest]){
            //pendingWithdrawls[richest]= users[richest];
            preRichest=richest;
            richest = msg.sender;
            return true;
        }
        return false;
    }

    function withdraw() external {
        uint value = users[msg.sender];
        users[msg.sender]=0;
        payable(msg.sender).transfer(value);
    }

    function getRichest() public view returns(address){
        return richest;
    }
}
*/