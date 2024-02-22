
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CryptoWalletInsurance {
    address public owner;
    uint256 public premium;
    uint256 public coverageAmount;
    bool public isClaimed;

    constructor(uint256 _premium, uint256 _coverageAmount) {
        owner = msg.sender;
        premium = _premium;
        coverageAmount = _coverageAmount;
        isClaimed = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function payPremium() external payable onlyOwner {
        require(msg.value == premium, "Incorrect premium amount");
        // Optionally, invest premium in other DeFi schemes
    }

    function claimInsurance() external onlyOwner {
        require(!isClaimed, "Insurance already claimed");
        // Perform necessary checks, e.g., recent hack events
        // If valid claim, transfer coverageAmount to the owner
        payable(owner).transfer(coverageAmount);
        isClaimed = true;
    }
}
