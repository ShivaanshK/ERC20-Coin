pragma solidity ^0.4.11;

import './IERC20.sol';

contract Plexus is IERC20 {
    
    uint public constant _totalSupply = 400000000; 
    
    string public constant symbol = "BLINK";
    string public constant name = "Plexus";
    uint8 public constant decimals = 3; 
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function MenloCoin() {
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() external constant returns (uint256 totalSupply){
        return _totalSupply;
    }
    
    function balanceOf(address _owner) external constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(
            balances[msg.sender] >= _value
            && _value > 0
        );
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
        require(
        allowed[_from][msg.sender] >= _value
        && balances[_from]>=_value
        && _value>0
        );
        
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from,_to,_value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) external returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender,_spender,_value);
        return true;
    }
    
    function allowance(address _owner, address _spender) external constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}    