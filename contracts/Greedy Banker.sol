pragma solidity >=0.4.22 <=0.8.17;

contract GreedyBanker {
    mapping(address => uint256) users;
    mapping(address => bool) check;

    address owner;
    uint feesCollected;

    uint256 constant fee = 1000 wei;


    constructor() public {
        owner = msg.sender;
    }
    receive() external payable {
        // Write your code here
        if (check[msg.sender]==false){
            users[msg.sender]+=msg.value;
            check[msg.sender]=true;
        }
        else{
            require(msg.value >= fee," Deposit too low");
            users[msg.sender] += msg.value - fee;
            feesCollected += fee;
        }

    }

    fallback() external payable {
        // Write your code here
        feesCollected += msg.value;
    }

    function withdraw(uint256 amount) external {
        // Write your code here
        require(users[msg.sender]>=amount,"Insufficient balance");
        users[msg.sender]-=amount;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "withdraw failed");
    }

    function collectFees() external {
        // Write your code here
        require(msg.sender == owner,"You are not the owner");
        (bool sent, ) = payable(msg.sender).call{value: feesCollected}("");
        require(sent, "withdraw failed");
        feesCollected=0;
    }

    function getBalance() public view returns (uint256) {
        // Write your code here
        return users[msg.sender];
    }
}
