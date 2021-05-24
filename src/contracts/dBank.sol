// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./Token.sol";

contract dBank {
  Token private token;
  //assign Token contract to variable

  //add mappings
  mapping (address => uint )  public etherBalanceOf;
  mapping (address => uint) public depositStart;
  mapping(address => bool) public isDeposited;

  //add events
  event deposite(address indexed user, uint enterAmmount,uint timeStart);

  //pass as constructor argument deployed Token contract
  constructor(Token _token) public {
    token= _token;
  }

  function deposit() payable public {
      require(!isDeposited[msg.sender] == false ,"you already deposted");
      require(msg.value>=1e16," value must be greater then 0.01 ether");
      etherBalanceOf[msg.sender] =  etherBalanceOf[msg.sender]+msg.value;
      depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
      isDeposited[msg.sender] = true;
      emit deposite(msg.sender, msg.value,block.timestamp);
  }

  function withdraw() public {
    require(isDeposited[msg.sender] = true, " no preview deposite");
    uint userBalance = etherBalanceOf[msg.sender];
    uint depositTime= block.timestamp + depositStart[msg.sender];

    uint intrestPerSecond=31668017 * (etherBalanceOf[msg.sender] / 1e16);

    uint intrest = intrestPerSecond * depositTime;

    //mint&send tokens to user
    msg.sender.transfer(userBalance);
    token.mint(msg.sender, intrest);

    etherBalanceOf[msg.sender]=0;
    isDeposited[msg.sender]= false;
    depositStart[msg.sender]= 0;
   

  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan
   
    //activate borrower's loan status

    //emit event
  }

  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}