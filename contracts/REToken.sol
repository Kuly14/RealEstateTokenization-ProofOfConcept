// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract REToken is ERC20 {

    event FundsReceived(uint indexed _amount);

    string public nameOfProperty;
    string public propertyAddress;
    string public propertyDescription;
    uint public sqMeters;
    uint public bedrooms;
    uint public bathrooms;

    address private owner;
    
    string public uri;

    uint lastStamp;

    constructor(
        address _caller,
        string memory _name, 
        string memory _address, 
        string memory _description, 
        uint _sqMeters, 
        uint _beds, 
        uint _baths,
        string memory _uri
        ) ERC20(_name, "REP") {

        _mint(_caller, _sqMeters * 10 ** decimals());
        storeData(_name, _address, _description, _sqMeters, _beds, _baths);
        uri = _uri;
        lastStamp = block.timestamp;
        owner = _caller;
        
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    function storeData(
        string memory _name, 
        string memory _address, 
        string memory _description, 
        uint _sqMeters, 
        uint _beds, 
        uint _baths
        ) private {

        nameOfProperty = _name;
        propertyAddress = _address;
        propertyDescription = _description;
        sqMeters = _sqMeters;
        bedrooms = _beds;
        bathrooms = _baths;
    }


    function distributeTokens() external onlyOwner {
        uint balance = address(this).balance;
        for (uint i = 0; i < owners.length; i++) {
            uint amountOfTokens = _balances[owners[i]];
            uint basisPointsOfTokens = (amountOfTokens * 10000) / totalSupply();
            uint amountToSend = (basisPointsOfTokens * balance) / 10000;
            (bool success,) = owners[i].call{value: amountToSend}("");
            require(success, "transaction didn't go through");
        }
    } 

    receive() external payable {
        emit FundsReceived(msg.value);
    }

    function withdraw(address _addr) external onlyOwner {
        (bool success,) = _addr.call{value: address(this).balance}("");
        require(success, "tx didnt go through");
    }
    
    function showBal() public view returns(uint){
        return address(this).balance;
    }
















}