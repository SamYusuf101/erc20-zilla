//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Zilla", "Zil") {
        _mint(msg.sender, initialSupply);
    }
}
