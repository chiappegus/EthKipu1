//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

import {IKing} from "./IKing.sol";

contract King is IKing {
    uint256 public apuestaMaxima;
    address public king;

    function bet() external payable {
        require(msg.value>apuestaMaxima,"aun no eres rey");
        apuestaMaxima= msg.value;
        payable(king).transfer(apuestaMaxima);
        king= msg.sender;
    }
}