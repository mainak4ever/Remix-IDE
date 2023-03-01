pragma solidity >=0.4.22 <=0.8.17;

contract GridMaker {


    function make2DIntGrid(
        uint256 rows,
        uint256 cols,
        int256 value
    ) public pure returns (int256[][] memory) {
        // Write your code here
        int [][] memory IntGrid;
        for (uint i; i<rows; i++){
            for (uint j; j<cols; j++){
                IntGrid[i][j]=value;
            }
        }

        return IntGrid;
    }

    function make2DAddressGrid(uint256 rows, uint256 cols)
        public
        view
        returns (address[][] memory)
    {
        // Write your code here
        address [][] memory addGrid;
        for (uint i; i<rows; i++){
            for (uint j; j<cols; j++){
                addGrid[i][j]=msg.sender;
            }
        }

        return addGrid;
    }
}