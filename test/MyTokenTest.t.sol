//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;
    DeployMyToken public deployer;
    uint256 public constant STARTING_BALANCE = 100 ether;
    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    address clement = makeAddr("clement");
    address henry = makeAddr("henry");

    function setUp() public {
        DeployMyToken deployMyToken = new DeployMyToken();
        myToken = deployMyToken.run();
        vm.prank(msg.sender);
        myToken.transfer(clement, STARTING_BALANCE);
    }

    function testClementBalance() public {
        assertEq(STARTING_BALANCE, myToken.balanceOf(clement));
    }

    function testAllowancesWorks() public {
        uint256 INITIAL_ALLOWANCE = 10 ether;
        uint256 INITIAL_TRANSFER_AMOUNT = 2 ether;

        vm.prank(clement);
        myToken.approve(henry, INITIAL_ALLOWANCE);

        vm.prank(henry);
        myToken.transferFrom(clement, henry, INITIAL_TRANSFER_AMOUNT);
        assertEq(myToken.balanceOf(henry), INITIAL_TRANSFER_AMOUNT);
        assertEq(
            myToken.balanceOf(clement),
            STARTING_BALANCE - INITIAL_TRANSFER_AMOUNT
        );
    }

    function testInitialSupplyAssignedToDeployer() public {
        assertEq(myToken.totalSupply(), INITIAL_SUPPLY);
        assertEq(
            myToken.balanceOf(msg.sender),
            INITIAL_SUPPLY - STARTING_BALANCE
        );
    }

    function testTransferExceedsBalance() public {
        uint256 tooMuch = STARTING_BALANCE + 1 ether;

        vm.prank(clement);
        vm.expectRevert(); // Should fail due to insufficient balance
        myToken.transfer(henry, tooMuch);
    }

    function testOverwriteAllowance() public {
        vm.prank(clement);
        myToken.approve(henry, 5 ether);

        vm.prank(clement);
        myToken.approve(henry, 10 ether);

        assertEq(myToken.allowance(clement, henry), 10 ether);
    }

    function testAllowanceDecreasesAfterTransferFrom() public {
        uint256 allowance = 15 ether;
        uint256 transferAmount = 10 ether;

        vm.prank(clement);
        myToken.approve(henry, allowance);

        vm.prank(henry);
        myToken.transferFrom(clement, henry, transferAmount);

        assertEq(myToken.allowance(clement, henry), allowance - transferAmount);
    }
}
