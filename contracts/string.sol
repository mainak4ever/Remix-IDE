pragma solidity >=0.4.22 <=0.8.17;

contract StringGenerator {
    mapping (address => bool)user;
    bytes word;
    function addCharacter(string memory character) public {
        // Write your code here
        require(word.length<=5,"Word length exceeded");
        require(user[msg.sender]!=true,"You already added Character");
        require(bytes(character).length==1,"Only single character allowed");
        
        word.push(bytes(character)[0]);
        user[msg.sender]=true;
    }

    function getString() public view returns (string memory) {
        // Write your code here
        return string(word);
    }
}