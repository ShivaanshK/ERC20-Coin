pragma solidity ^0.4.11;

import './IERC20.sol';
import './SafeMath.sol';

contract MenloCoin is IERC20 {
    
    uint public constant _totalSupply = 0; 
    using SafeMath for uint256;
    string public constant symbol = "Plexus";
    string public constant name = "Plexus";
    uint8 public constant decimals = 18; 
    uint256 public constant RATE = 1000;
    address public owner;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function () payable {
        createTokens();
    }
    
    function MenloCoin() {
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() external constant returns (uint256 totalSupply){
        owner = msg.sender;
    }
    
    function createTokens() payable {
        require(msg.value > 0);
        
        uint256 tokens = msg.value.mul(RATE);
        balances[msg.sender] = balances[msg.sender].add(tokens);
        
        owner.transfer(msg.value);
    }
    
    function balanceOf(address _owner) external constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(
            balances[msg.sender] >= _value
            && _value > 0
        );
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[msg.sender].add(_value);
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
        require(
        allowed[_from][msg.sender] >= _value
        && balances[_from]>=_value
        && _value>0
        );
        
        balances[_from] = balances[msg.sender].sub(_value);
        balances[_to] = balances[msg.sender].add(_value);
        allowed[_from][msg.sender] = balances[msg.sender].sub(_value);
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
