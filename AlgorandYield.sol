// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract AlgorandYieldOptimizer {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;

  address public owner;
  uint256 public totalSupply;
  mapping(address => uint256) public balances;
  event Transfer(address from, address to, uint256 value);

  constructor() public {
    owner = msg.sender;
    totalSupply = 0;
  }

  function deposit() public payable {
    require(msg.value != 0);
    balances[msg.sender] += msg.value;
    totalSupply += msg.value;
    emit Transfer(address(0), msg.sender, msg.value);
  }

  // This function allows users to withdraw their deposited tokens
  function withdraw(uint256 memory _amount) public {
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] -= _amount;
    totalSupply -= _amount;
    msg.sender.transfer(_amount);
    emit Transfer(msg.sender, address(0), _amount);
  }

  // This function transfers tokens from one user to another
  function transfer(address payable _to, uint256 memory _amount) public {
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] -= _amount;
    totalSupply -= _amount;
    balances[_to] += _amount;
    _to.transfer(_amount);
    emit Transfer(msg.sender, _to, _amount);
  }
}