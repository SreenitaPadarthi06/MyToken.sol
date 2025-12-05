// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyToken {
    // Metadata
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Balances and allowances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @notice Constructor mints `_initialSupply` tokens (in whole tokens, scaled by decimals) to deployer
    /// @param _initialSupply supply in whole tokens (e.g., 1_000_000)
    constructor(uint256 _initialSupply) {
        // scale supply according to decimals
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    /// @notice Transfer tokens from caller to `_to`
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Cannot transfer to zero address");
        require(balanceOf[msg.sender] >= _value, "Not enough balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /// @notice Approve `_spender` to spend `_value` on caller's behalf
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0), "Cannot approve zero address");

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @notice transfer tokens from `_from` to `_to` using allowance
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Cannot transfer to zero address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    /// @notice Optional helpers to safely change allowance
    function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool) {
        require(_spender != address(0), "Cannot approve zero address");
        allowance[msg.sender][_spender] += _addedValue;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool) {
        require(_spender != address(0), "Cannot approve zero address");
        uint256 current = allowance[msg.sender][_spender];
        require(current >= _subtractedValue, "Decreased allowance below zero");
        allowance[msg.sender][_spender] = current - _subtractedValue;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    /// @notice Mint tokens to `_to`. WARNING: public mint — anyone can call it.
    /// If you want only owner to mint, add Ownable and restrict access.
    function mint(address _to, uint256 _amount) public {
        require(_to != address(0), "Cannot mint to zero address");
        balanceOf[_to] += _amount;
        totalSupply += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    /// @notice Helpers (redundant because totalSupply is public) kept for task clarity
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getTokenInfo() public view returns (string memory, string memory, uint8, uint256) {
        return (name, symbol, decimals, totalSupply);
    }
}
