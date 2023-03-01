pragma solidity >=0.4.22 <=0.8.17;

contract MathUtils {
    function floor(int256 value) public pure returns (int256) {
        // Write your code here
        int q = value / 10;
        return q*10;
    }

    function ceil(int256 value) public pure returns (int256) {
        // Write your code here
        if(value < 0){
            int q=value/10;
            q--;
            return q*10;
        }
        else{
            int q=value/10;
            q++;
            return q*10;
        }
    }

    function average(int256[] memory values, bool down)
        public
        pure
        returns (int256)
    {
        // Write your code here
        int s;
        for (uint8 i; i< values.length ; i++){
            s+=values[i];
        }
        int avg = s/int(values.length);

        if (down == true){
            return floor(avg);
        }
        else{
            return ceil(avg);
        }
        return 0;
    }
}
