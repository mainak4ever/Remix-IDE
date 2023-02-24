pragma solidity >=0.4.22 <=0.8.17;

contract LargestHolder {
    address[] holders;
    uint[] balances;
    uint txRequired;
    uint start;
    uint end;
    address largestHolder;
    uint largestBalance;
    bool balancesSubmitted;

    function submitBalances(
        uint256[] memory _balances,
        address[] memory _holders
    ) public {
        // Write your code here
        require(!balancesSubmitted, "Balances have already been submitted");
        balancesSubmitted = true;
        holders = _holders;
        balances = _balances;

        txRequired = holders.length/10;
        if (txRequired*10 < holders.length){
            txRequired++;
        }

        end = 10;
        if (end > holders.length){
            end = holders.length;
        }   
    }

    function process() public {
        // Write your code here
        require(balancesSubmitted,"Balances not submitted");
        require(txRequired>0,"All balances already processed");

        for(uint i = start; i<end;i++){
            if (balances[i] > largestBalance){
                largestHolder = holders[i];
                largestBalance = balances[i];
            }
        }
        start = end;
        end += 10;
        if(end > balances.length){
            end = balances.length;
        }
        txRequired--;
    }

    function numberOfTxRequired() public view returns (uint256) {
        // Write your code here
        require(balancesSubmitted,"Balances not submitted");
        return txRequired;
    }

    function getLargestHolder() public view returns (address) {
        // Write your code here
        require(balancesSubmitted,"Balances not submitted");
        require(txRequired==0,"Processing not completed");
        return largestHolder;
    }
}
