// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface IKing {
    // Función para realizar una apuesta
    function bet() external payable;
    
    // Función para obtener la apuesta máxima actual
    function apuestaMaxima() external view returns (uint256);
    
    // Función para obtener la dirección del rey actual
    function king() external view returns (address);
}