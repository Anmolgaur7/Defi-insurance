// CollateralProtection.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CollateralProtection {
    address public owner;
    uint256 public loanAmount;
    uint256 public collateralValue;
    uint256 public coveragePercentage;
    bool public isClaimed;

    constructor(uint256 _loanAmount, uint256 _collateralValue, uint256 _coveragePercentage) {
        owner = msg.sender;
        loanAmount = _loanAmount;
        collateralValue = _collateralValue;
        coveragePercentage = _coveragePercentage;
        isClaimed = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function updateCollateralValue(uint256 _newCollateralValue) external onlyOwner {
        collateralValue = _newCollateralValue;
    }

    function claimInsurance() external onlyOwner {
        require(!isClaimed, "Insurance already claimed");
        // Perform necessary checks, e.g., drop in collateral value
        uint256 payoutAmount = (collateralValue * coveragePercentage) / 100;
        // If valid claim, transfer the appropriate amount to the owner
        payable(owner).transfer(payoutAmount);
        isClaimed = true;
    }
}
