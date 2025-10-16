// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {




    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 100 * 10 ** decimals());
    }
        /// @dev siempre para sobreEscribir tiene que tener la palabra virtual.
        /// @dev el saca lo de virtual pero tira error , aca podes poner pure .
        function decimals() override public view virtual returns (uint8) {
        return 1;
    }
    ///@dev 
}
