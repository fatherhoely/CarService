// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarService {
    struct ServiceRequest {
        uint requestID;
        address customer;
        CarDetails carDetails;
        bool isCompleted;
    }

    struct CarDetails {
        string make;
        string model;
        uint year;
        string problemDescription;
        uint carID;
    }

    uint public requestCount = 0;
    mapping(uint => ServiceRequest) public requests;
    mapping(address => uint) public loyaltyPoints;

    function requestService(
        string memory make, 
        string memory model, 
        uint year, 
        string memory problemDescription, 
        uint carID
    ) public {
        requestCount++;
        requests[requestCount] = ServiceRequest(
            requestCount,
            msg.sender,
            CarDetails(make, model, year, problemDescription, carID),
            false
        );
        loyaltyPoints[msg.sender] += 10; // Add loyalty points for the service request
    }

    function requestServiceWithPoints(
        string memory make, 
        string memory model, 
        uint year, 
        string memory problemDescription, 
        uint carID
    ) public {
        require(loyaltyPoints[msg.sender] >= 50, "Not enough points to pay with points");
        loyaltyPoints[msg.sender] -= 50;
        requestCount++;
        requests[requestCount] = ServiceRequest(
            requestCount,
            msg.sender,
            CarDetails(make, model, year, problemDescription, carID),
            false
        );
    }

    function getServiceRequest(uint requestID) public view returns (ServiceRequest memory) {
        return requests[requestID];
    }

    function getPointsBalance(address customer) public view returns (uint) {
        return loyaltyPoints[customer];
    }
}
