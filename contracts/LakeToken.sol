// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract LakeToken is ERC20 {
    constructor() ERC20("Lake Token", "LAKE") {
        // Minting 100 tokens to the owner address
        _mint(msg.sender, 100 * 10**(decimals()));
    }
}
