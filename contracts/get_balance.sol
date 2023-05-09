// This contract gets the balance of the tokens of the specified token address from an account.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract TokenBalance {
    function getTokenBalance(address tokenAddress, address accountAddress) public view returns (uint) {
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(accountAddress);
    }
}