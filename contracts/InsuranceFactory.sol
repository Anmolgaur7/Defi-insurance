// InsuranceFactory.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Cryptowalletins.sol";
import "./Collateralinsurance.sol";

contract InsuranceFactory {
    enum InsuranceType { CryptoWallet, CollateralProtection }

    mapping(address => address[]) public userToContracts;

    event InsuranceContractCreated(address indexed user, address contractAddress);

    function createCryptoWalletInsurance(uint256 premium, uint256 coverageAmount) external {
        CryptoWalletInsurance newContract = new CryptoWalletInsurance(premium, coverageAmount);
        userToContracts[msg.sender].push(address(newContract));
        emit InsuranceContractCreated(msg.sender, address(newContract));
    }

    function createCollateralProtection(uint256 loanAmount, uint256 collateralValue, uint256 coveragePercentage) external {
        CollateralProtection newContract = new CollateralProtection(loanAmount, collateralValue, coveragePercentage);
        userToContracts[msg.sender].push(address(newContract));
        emit InsuranceContractCreated(msg.sender, address(newContract));
    }

    function getUserContracts(address user) external view returns (address[] memory) {
        return userToContracts[user];
    }
}
