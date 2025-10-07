//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

import {IKing} from "./IKing.sol";

contract King is IKing {
    uint256 public apuestaMaxima;
    address public king;
    //se suma una varaible por el tema del balance.
    mapping (address => uint256) public balances;

    function bet() external payable {
        require(msg.value>apuestaMaxima,"aun no eres rey");
        apuestaMaxima= msg.value;
        //payable(king).transfer(apuestaMaxima);===>> éste es el problema..
          //se debe hacer un mapping para que funcione el balance
        //balances[msg.sender] += msg.value;
        balances[king] += apuestaMaxima;
        king= msg.sender;
    }
    // function getBalance() external view returns (uint256){
    //     return balances[king];
    // }
    function getKing() external view returns (address){
        return king;
    }

    function claim () external {     //funcion para sacar el dinero
    payable(king).transfer(balances[msg.sender]);
}


}


    

         
    
