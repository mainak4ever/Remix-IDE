pragma solidity >=0.4.22 <=0.8.17;

contract Item {
    string name;
    uint price;
    constructor(string memory _name, uint _price) {
        name = _name;
        price = _price; 
    }

    function getName()public view returns(string memory){
        return name;
    }

    function getPrice()public view virtual returns(uint){
        return price;
    }
}

contract TaxedItem is Item{
    // Write your code here
    uint tax;
    constructor(string memory name, uint price, uint _tax)Item (name, price){
        tax=_tax;
    }

    function getPrice()public view override returns(uint){
        return price + tax;
    }
}
