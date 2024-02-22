// CryptoWalletInsurance.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CryptoWalletInsurance {
    address public owner;
    uint256 public premium;
    uint256 public coverageAmount;
    uint256 public lastPremiumPaymentTimestamp;
    bool public isClaimed;

    // Constructor
    constructor(uint256 _premium, uint256 _coverageAmount) {
        owner = msg.sender;
        premium = _premium;
        coverageAmount = _coverageAmount;
        lastPremiumPaymentTimestamp = block.timestamp;
        isClaimed = false;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to pay the insurance premium
    function payPremium() external payable onlyOwner {
        require(msg.value == premium, "Incorrect premium amount");

        // Check if a month has passed since the last premium payment
        require(block.timestamp >= lastPremiumPaymentTimestamp + 30 days, "Premium not due yet");

        lastPremiumPaymentTimestamp = block.timestamp;
    }

    // Function for the owner to claim insurance
    function claimInsurance() external onlyOwner {
        require(!isClaimed, "Insurance already claimed");

        // Check if the premium for the current month has been paid
        require(block.timestamp >= lastPremiumPaymentTimestamp + 30 days, "Premium not paid for the current month");

        // Perform necessary checks, e.g., recent hack events
        if(msg.sender.balance==0) {
            // If not enough funds, transfer the remaining balance to the owner
        payable(owner).transfer(coverageAmount);
        isClaimed = true;
        }
        // If a valid claim, transfer coverageAmount to the owner
       
    }
}
