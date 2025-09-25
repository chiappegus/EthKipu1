
(no borrar los links) Link original => https://pad.riseup.net/p/EthKipuPM2cuat-keep



Gitbook Completo: https://ethkipu.gitbook.io/edp-v2-es/
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


