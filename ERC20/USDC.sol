// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

///@dev ahora se van a poner permisos de https://wizard.openzeppelin.com/ para que el que setee la Wlist Sea solo el Owner.
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import "./ERC20.sol";
///https://youtu.be/w9778DlUsAQ?list=PL_r-IuCAlAeeI21VCmwdOWBZhPPwKs2Qz&t=3450
contract USDC is ERC20 ,Ownable{
    ///@dev las personas que este en la lista pueden recibir token. y vamos a traer de token el _transfers y override
    mapping(address => bool) private  whiteList;
    error NoTwhiteList(address,string);

    constructor() ERC20("USD Coin", "USDC") Ownable(msg.sender)  {}

    /// @dev la de arriba ahora le vamos aplicar una funcion interna para que no pueda ser modificada afuera ::
    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) internal override  returns (bool success) {
         ///modificacion ::=>
         if(whiteList[_to] == false) revert NoTwhiteList (_to, "No esta en la lista");
        //con esto le digo que lo de abajo no lo modifico.  
        return super._transfer(_from, _to, _value);
    }

    ///@dev aca solo lo puede modificar la lista el onlyOwner
    function SetWhiteList(address _to , bool _whiteList) external onlyOwner {
            
            whiteList[_to]=_whiteList;

    }
    
    