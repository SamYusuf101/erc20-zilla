//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;
    DeployMyToken public deployer;
    uint256 public constant STARTING_BALANCE = 10 ether;
    address clement = makeAddr("clement");
    address henry = makeAddr("henry");

    function setUp() public {
        DeployMyToken deployMyToken = new DeployMyToken();
        myToken = deployMyToken.run();
    }

    function testclementBalance() public {
        vm.prank(msg.sender);
        myToken.transfer(clement, STARTING_BALANCE);
        assertEq(STARTING_BALANCE, myToken.balanceOf(clement));
    }
}
