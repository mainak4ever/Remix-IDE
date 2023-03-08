pragma solidity >=0.4.22 <=0.8.17;

interface Driveable {
    // Write your code here
    function startEngine() external ;

    function stopEngine() external ;

    function fuelUp(uint liters) external ;
    
    function drive(uint kilometers) external ;

    function kilometersRemaining() external view returns (uint);
}

abstract contract GasVehicle is Driveable {
    // Write your code here
    uint litresRemaining;
    bool started;

    modifier tankfull(uint liters){
        require(liters + litresRemaining <= getFuelCapacity());
        _;
    }

    modifier sufficientfuel(uint kilometers){
        require(kilometersRemaining() >= kilometers);
        _;
    }

    modifier isStarted(){
        require(started == true);
        _;
    }

    modifier isStopped(){
        require(started == false);
        _;
    }


    function startEngine() external{
        started =true;
    }

    function stopEngine() external{
        started = false;
    }

    function fuelUp(uint liters) external isStopped tankfull(liters){
        litresRemaining += liters;
    }

    function drive(uint kilometers) external isStarted sufficientfuel(kilometers){
        litresRemaining -= kilometers/getKilometersPerLitre();
    }

    function kilometersRemaining() public view returns (uint) {
        return litresRemaining*getKilometersPerLitre();
    }

    function getKilometersPerLitre() public view virtual returns(uint);

    function getFuelCapacity() public view virtual returns(uint);
}

contract Car is GasVehicle {
    // Write your code here
    uint fuelTankSize;
    uint kilometersPerLitre;

    constructor(uint _fuelTankSize, uint _kilometersPerLitre){
        fuelTankSize = _fuelTankSize;
        kilometersPerLitre = _kilometersPerLitre;
    }

    function getKilometersPerLitre() public view override  returns(uint){
        return kilometersPerLitre;
    }

     function getFuelCapacity() public view override returns(uint){
         return fuelTankSize;
     }
}
