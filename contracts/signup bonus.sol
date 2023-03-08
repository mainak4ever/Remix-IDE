pragma solidity >=0.4.22 <=0.8.17;

abstract contract SignUpBonus {
    mapping(address => uint)balances;
    mapping(address => bool)deposited;
    // Write your code here
    function getBonusAmount() internal pure virtual returns(uint256);

    function getBonusRequirement() internal pure virtual returns(uint256);

    function deposit() public payable {
        if (deposited[msg.sender] == false && msg.value > getBonusRequirement()) {
            balances[msg.sender] += getBonusAmount();
            deposited[msg.sender]=true;
        }
        balances[msg.sender]+=msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender]>=amount,"You dont have sufficient balance");
        balances[msg.sender] -= amount;
        (bool sent, )=payable(msg.sender).call{value: amount}("");
        require(sent, "failed to send");
    }

    function getBalance()public view returns(uint){
        return balances[msg.sender];
    }
}

contract Bank is SignUpBonus {
    function getBonusAmount()internal pure override returns(uint){
        return 150 wei;
    }

    function getBonusRequirement() internal pure override returns(uint){
        return 1000 wei;
    }

    
}
