
(no borrar los links) Link original => https://pad.riseup.net/p/EthKipuPM2cuat-keep
Gitbook Completo: https://ethkipu.gitbook.io/edp-v2-es/

Módulo 1: Clase 1 Fecha: 4/9/25

gitbook: 
https://ethkipu.gitbook.io/edp-v2-es/modulo-1/intro-a-smart-contracts/fundamentos-de-blockchain
    
Guias:
    https://docs.google.com/presentation/d/1kcVWplX_RFVdGJI4wNapiUODm3duUl97X6FDGSzZ9UE/edit?slide=id.g2f76ccc8cbe_0_229#slide=id.g2f76ccc8cbe_0_229
    https://docs.google.com/presentation/d/1xdPmQTfkUdrMcFO5jSW1biSzxnuiP-oH/edit?slide=id.g1e0cc3a9bca_0_93#slide=id.g1e0cc3a9bca_0_93
    
Grupo de telegram: https://t.me/+2DyGjvAPehUyOTkx

Taller de Criptografía y Wallets:
 https://github.com/DigiCris/Taller_criptografia_y_wallets/blob/main/criptografia_wallets.pdf
 
Libro Mastering Ethereu
 
https://github.com/ethereumbook/ethereumbook

Demo Blockchain
https://andersbrownworth.com/blockchain/block


Modulo 1 clase 2: 9/9/25

Guía usada en la clase de hoy:
https://docs.google.com/presentation/d/10UNE-6EIvajQ9MG6KOSt2Xw9_ilcqPah/edit

Esta otra guía la veremos la clase que viene pero puede verse como resumen también de lo de hoy algunas cosas así quela agrego:
https://docs.google.com/presentation/d/14J6HJC-uX1ZHGzvE7D_6HgU3--VFRYp2GGQPavZp6hs/edit?slide=id.p#slide=id.p


Repaso:
https://andersbrownworth.com/blockchain/hash
https://andersbrownworth.com/blockchain/public-private-keys/keys

Pedido de Airdrop de Eth sepolia para hacer tarea= https://pad.riseup.net/p/faucet => https://sepolia.etherscan.io/tx/0xded1b539e463227f4de97fbf02563ec949f4cc43f96fabce67ae6b315cb04ce2

evm.codes => opcodes

  este funciona (Faucet):
     https://cloud.google.com/application/web3/faucet/ethereum/sepolia

EVM codigo simplificado: https://github.com/DigiCris/easyEVM

11/9/25: clase 3-mod1

cuentas como SC = https://www.youtube.com/watch?v=n6hr1g36oXw

codificador abi = https://abi.hashex.org/

chainlist para nodos = https://chainlist.org/?search=ethereum

keccka256 = https://emn178.github.io/online-tools/keccak_256.html

Campus virtual = https://campus.ethkipu.org

Remix = https://remix.ethereum.org/

Contrato deployado y verificado = https://sepolia.etherscan.io/address/0xaa050942f99f4c29c95c013366bbd48a5d6d2473#readContract

 18/9/2025: clase 2:modulo 2
 
 Spreadsheet de proyecto grupal extra currucular: https://docs.google.com/spreadsheets/d/1en_2vI7W1PcofaQJ1UB9_LJC_PG07Ng7MqqLOGQSyjk/edit?usp=sharing
 
 github con codigo: https://github.com/DigiCris/EthKipuPM/blob/main/module2/class4/Message.sol
 
 23/9/2025:
     
     programa ejemplo: https://github.com/DigiCris/EducationIT/blob/main/clase2/solidity1.sol
     
     ToDoList.sol enunciado:
         Vamos a partir del siguiente enunciado:
Contrato "ToDoList"
Desarrolla un contrato en Solidity llamado ToDoList que permita gestionar tareas. Debe incluir:

Estructura Tarea:

Descripción (cadena de texto).
Tiempo de creación (entero).
Array:

s_tareas: almacena las tareas.
Eventos:

ToDoList_TareaAñadida.
ToDoList_TareaCompletadaYEliminada.
Funciones:

setTarea(string _descripcion): añade una tarea.
eliminarTarea(string _descripcion): elimina una tarea completada.
getTarea(): retorna todas las tareas.
Incluye comentarios explicativos en el código.

Codigo:
    
    /*
Contrato "ToDoList"
Desarrolla un contrato en Solidity llamado ToDoList que permita gestionar tareas. Debe incluir:

Estructura Tarea:
Descripción (cadena de texto).
Tiempo de creación (entero).

Array:

s_tareas: almacena las tareas.

Eventos:

ToDoList_TareaAñadida.
ToDoList_TareaCompletadaYEliminada.

Funciones:

setTarea(string _descripcion): añade una tarea.
eliminarTarea(string _descripcion): elimina una tarea completada.
getTarea(): retorna todas las tareas.
Incluye comentarios explicativos en el código.
*/

// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract ToDoList {

    enum State {
        SinHacer,
        Completado
    }

    struct Tarea {
        string description;
        uint256 creationTime;
        uint256 index;
        State state;
    }

    Tarea[] public tarea; // tarea[indice]
    uint256 private nextIndex;

    event TaskAdded(uint256 indexed index,string indexed description, uint256 creationTime);
    event TaskedStatusChanged(uint256 indexed index,string indexed description,string indexed newStatus);

    function setTarea(string calldata _description) external {
        uint256 _lastIndex = nextIndex++;
        tarea.push(Tarea(_description,block.timestamp,_lastIndex,State.SinHacer));
        emit TaskAdded(_lastIndex,_description, block.timestamp);
    }

    function getTareas() external view returns (Tarea[] memory) {
        return tarea;
    }

    function eliminarTarea(string calldata _descripcion) external {
        uint256 len = tarea.length;
        for(uint256 i; i<len;) {
            if(keccak256(bytes(tarea[i].description)) == keccak256(bytes(_descripcion))) {
                emit TaskedStatusChanged(tarea[i].index,tarea[i].description,"eliminado");
                tarea[i] = tarea[len-1];
                tarea.pop();
                break;
            }
            unchecked {
                ++i;
            }
        }
    }

    function completarTarea(string calldata _descripcion) external {
        uint256 len = tarea.length;
        for(uint256 i; i<len;) {
            if(keccak256(bytes(tarea[i].description)) == keccak256(bytes(_descripcion))) {
                emit TaskedStatusChanged(tarea[i].index,tarea[i].description,"Completado");
                tarea[i].state = State.Completado;
                break;
            }
            unchecked {
                ++i;
            }
        }
    }

}





25/9/2025: clase 4 Modulo 2

Enunciado del problema:
    
    Crea un contrato Solidity llamado `Donations` con las siguientes características:

1. **Variables**:
   - Una variable inmutable `beneficiary` (address) para el que puede retirar donaciones.
   - Un mapping `donations` (address => uint256) para rastrear las donaciones por usuario.

2. **Eventos**:
   - Un evento `DonationReceived` que emite la dirección del donante y el monto.
   - Un evento `WithdrawalPerformed` que emite la dirección del receptor y el monto retirado.

3. **Errores**:
   - Un error `TransactionFailed` que recibe un argumento de tipo `bytes`.
   - Un error `UnauthorizedWithdrawer` que recibe dos argumentos de tipo `address`: el llamador y el beneficiario.

4. **Funciones**:
   - Un constructor que recibe una dirección para `beneficiary`.
   - Una función `receive` para aceptar Ether directamente.
   - Una función `donate` que permite a los usuarios donar Ether, actualiza su monto de donación y emite el evento `DonationReceived`.
   - Una función `withdraw` que permite solo al beneficiario retirar un monto específico y emite el evento `WithdrawalPerformed`.
   - Una función privada `_transferEth` que realiza la transferencia de Ether y revierte en caso de fallo.

Asegúrate de que el contrato sea compatible con la versión de Solidity 0.8.26 y de incluir el identificador de licencia SPDX al principio.







Codigo primera parte de la clase:
    // SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract KipuBankNotFinished {

    error InvalidValue();
    event paid(address indexed  payer, uint256 amount);

    mapping(address=>uint256) public balance; // no se pueden recorrer
    // key => valor

    address[] public addr;


    function pay() external payable {
        if (msg.value != 0.1 ether) revert InvalidValue();
        balance[msg.sender] += msg.value;
        addr.push(msg.sender);
        emit paid(msg.sender, msg.value);
    }
    
   bool flag;
   modifier reentrancyGuard() {
      if(flag != 0) revert();
      flag = 1;
      _;
      flag = 0;
   }


    function withdraw() external reentrancyGuard returns(bytes memory) {
        address to = msg.sender;
        uint256 miBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        (bool success, bytes memory data) = to.call{value: miBalance}("");
        if(!success) revert();
        return data;
    }

    function withdraw2() external{
        address payable to = payable(msg.sender); // send, transfer
        uint256 miBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        to.transfer(miBalance); // gas = 2300
    }

    function withdraw3() external{
        address payable to = payable(msg.sender); // send, transfer
        uint256 miBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        bool success = to.send(miBalance); // gas = 2300
        if (!success) revert();
    }

}














Donations.sol:
    
    /*
Crea un contrato Solidity llamado `Donations` con las siguientes características:

1. **Variables**:
   - Una variable immutable `beneficiary` (address) para el que puede retirar donaciones.
   - Un mapping `donations` (address => uint256) para rastrear las donaciones por usuario.

2. **Eventos**:
   - Un evento `DonationReceived` que emite la dirección del donante y el monto.
   - Un evento `WithdrawalPerformed` que emite la dirección del receptor y el monto retirado.

3. **Errores**:
   - Un error `TransactionFailed` que recibe un argumento de tipo `bytes`.
   - Un error `UnauthorizedWithdrawer` que recibe dos argumentos de tipo `address`: el llamador y el beneficiario.

4. **Funciones**:
   - Un constructor que recibe una dirección para `beneficiary`.
   - Una función `receive` para aceptar Ether directamente.
   - Una función `donate` que permite a los usuarios donar Ether, actualiza su monto de donación y emite el evento `DonationReceived`.
   - Una función `withdraw` que permite solo al beneficiario retirar un monto específico y emite el evento `WithdrawalPerformed`.
   - Una función privada `_transferEth` que realiza la transferencia de Ether y revierte en caso de fallo.

Asegúrate de que el contrato sea compatible con la versión de Solidity 0.8.26 y de incluir el identificador de licencia SPDX al principio.
*/

// SPDX-License-Identifier: MIT
pragma solidity > 0.8.0;

contract Donations {
   address immutable public BENEFICIARY; // eficiente a nivel de gas
   address constant public BENEFICIARY2 = address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
   mapping (address => uint256) public donations;

   event DonationReceived(address sender, uint256 amount);
   event WithdrawalPerformed(address beneficiary, uint256 amount);

   error TransactionFailed(bytes reason);
   error UnauthorizedWithdrawer(address caller, address beneficiary);

   modifier onlyBeneficiary() {
      if (msg.sender != BENEFICIARY) revert UnauthorizedWithdrawer(msg.sender, BENEFICIARY);
      _;
   }

   constructor(address _beneficiary) {
      BENEFICIARY = _beneficiary;
   }

   receive() external payable {
      donations[msg.sender] += msg.value;
      emit DonationReceived(msg.sender, msg.value);
   }

   fallback() external payable {
      donations[msg.sender] += msg.value;
      emit DonationReceived(msg.sender, msg.value);
   }

   function donate() external payable {
      donations[msg.sender] += msg.value;
      emit DonationReceived(msg.sender, msg.value);
   }

   function withdraw() external onlyBeneficiary returns(bytes memory data){
      emit WithdrawalPerformed(BENEFICIARY, address(this).balance); // efect
      data = _transferEth(BENEFICIARY, address(this).balance); // interacion
      return data;
   }

   function _transferEth(address to, uint256 amount) private returns (bytes memory) {
      (bool success, bytes memory data) = to.call{value:amount}("");
      if(!success) revert TransactionFailed("call failed");
      return data;
   }

}
