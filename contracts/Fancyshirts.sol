pragma solidity >=0.4.22 <=0.8.17;

contract FancyShirts {
    // Write your code here
   
    enum Size {
        Small,
        Medium,
        Large 
    }

    enum Color{
        Red,
        Green,
        Blue
    }

    struct shirt{
        Size size;
        Color color;
    }
    mapping(address => shirt[]) Buyers;


    modifier correctAmount(Size size, Color color) {
        require(
            getShirtPrice(size, color) == msg.value,
            "incorrect amount sent"
        );
        _;
    }

    
    function getShirtPrice(Size size, Color color)public pure returns(uint){
        uint price;
        if(size == Size.Small){
            price+= 10;
        }
        else if(size == Size.Medium){
            price+= 15;
        }
        else {
            price+= 20;
        }

        if(color != Color.Red){
            price+= 5;
        }

        return price;

    }

    function buyShirt(Size size, Color color) public payable correctAmount(size,color){
        Buyers[msg.sender].push(shirt(size,color));
    }

    function getShirts(Size size, Color color) public view returns (uint256) {
        uint8 count;
        for(uint i; i < Buyers[msg.sender].length; i++){
            if (Buyers[msg.sender][i].size == size &&Buyers[msg.sender][i].color == color){
                count++;
            }
        }
        return count;
    }

}
