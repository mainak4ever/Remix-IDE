pragma solidity >=0.4.22 <=0.8.17;

contract Competitors {
    // Write your code here
    address owner;

    address first;
    address second;
    address winner;

    uint deposit1;
    uint deposit2;

    bool withdrew;

    constructor(){
        owner=msg.sender;
    }

    function deposit() external payable{
        require(msg.value==1 ether,"Can deposit only 1 ether");
        require(deposit1 + deposit2 < 3 ether,
        "3 Ethereum has been received, no more deposits are accepted");

        if (deposit1==0){
            first=msg.sender;
        }
        else if(deposit2==0){
            second=msg.sender;
        }

        if ( first == msg.sender){
            deposit1+=msg.value;
        }
        else if (second==msg.sender){
            deposit2+=msg.value;
        }
        else{
            revert("You are not a valid Depositor");
        }

        if (deposit1 + deposit2>=3 ether){
            if (deposit1>deposit2){
                winner = first;
            }
            else{
                winner=second;
            }
        }
    }

    function withdraw() external {
        require(msg.sender==winner,"You are not the winner");
        payable(winner).call{value:3 ether}("");
        withdrew=true;
    }

    function destroy()external{
        require(owner==msg.sender,"You are not the owner");
        require(withdrew==true,"Winner not decided");
        selfdestruct(payable(owner));
    }
}
