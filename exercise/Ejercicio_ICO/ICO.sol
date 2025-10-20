// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;    

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ICO {

IERC20 immutable public token  ;

uint256 immutable public  price;


constructor ( IERC20 _token ,uint256  _price){
    token =_token;
    price=_price;

}

function buy() external payable  {

uint256 amount = msg.value/price;   

token.transfer(msg.sender, amount);

}

//https://youtu.be/dVxu0alH2ys?list=PL_r-IuCAlAeeI21VCmwdOWBZhPPwKs2Qz

function sell(uint256 _amount)   external  {
///@dev spreed compra y venta
    uint256 ehtAmount =( _amount * price *98)/100;

    ///@dev no oficial
    // payable(msg.sender).transfer(ehtAmount); 
    ///@dev  oficial

     (bool succes, )   =payable(msg.sender).call{value: ehtAmount}("");
     if(!succes) revert();

    


    
}


}