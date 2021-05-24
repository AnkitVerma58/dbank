// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {

  address public minter; 

  event minterChange(address indexed from ,address to);

  constructor() public payable ERC20("Decentralize Bank Cyrrency", "DBC") {
   minter=msg.sender;
  }
  function passMinterRole(address dbank) public returns (bool){
    require(msg.sender==minter, "only owner can change pass mint value");
    minter == dbank;
    emit minterChange(msg.sender,dbank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
		_mint(account, amount);
	}
}