pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
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
        uint value = users[preRichest];
        users[preRichest]=0;
        payable(preRichest).transfer(value);
    }

    function getRichest() public view returns(address){
        return richest;
    }
}
