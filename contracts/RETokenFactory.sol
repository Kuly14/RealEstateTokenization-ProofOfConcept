// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./REToken.sol";


contract RETokenFactory {

    event PropertyRegistered(
        address indexed _addrOfContract,
        string _name,
        string _address,
        string _description,
        uint _sqMeters,
        uint _beds,
        uint _baths, 
        string _uri
    );
    
    // Stores Address => ifThereIsThatListingAlready
    mapping(string => bool) public alreadyExists;
    mapping(string => address) public addressOfPropertyToken;
    REToken[] public contracts;



    function createToken(
        address _caller,
        string memory _name,
        string memory _address,
        string memory _description,
        uint _sqMeters,
        uint _beds,
        uint _baths, 
        string memory _uri
        ) external {
        require(
            alreadyExists[_address] == false,
            "This property is already listed"    
        );
        REToken token = new REToken(_caller, _name, _address, _description, _sqMeters, _beds, _baths, _uri);
        contracts.push(token);
        uint index = contracts.length - 1;
        address lastAddress = address(contracts[index]);
        alreadyExists[_address] = true;
        addressOfPropertyToken[_address] = lastAddress;
        emit PropertyRegistered(lastAddress, _name, _address, _description, _sqMeters, _beds, _baths, _uri);
    }

    





















}