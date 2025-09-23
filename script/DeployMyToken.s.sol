//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (MyToken) {
        vm.startBroadcast();
        MyToken myToken = new MyToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return myToken;
    }
    
}

// llllllllll
// 

// import {Test} from "forge-std/Test.sol";
// import {DeployMyToken} from "../script/DeployMyToken.s.sol";
// import {MyToken} from "../src/MyToken.sol";

// contract MyTokenTest is Test {
//     MyToken public myToken;
//     DeployMyToken public deployer;

//     uint256 public constant STARTING_BALANCE = 100 ether;
//     uint256 public constant INITIAL_SUPPLY = 1000 ether;

//     address public clement = makeAddr("clement");
//     address public henry = makeAddr("henry");
//     address public deployerAddress;

//     function setUp() public {
//         // Optional: simulate deployer as a known address
//         deployerAddress = address(this); // if DeployMyToken uses msg.sender

//         // Deploy token using script
//         DeployMyToken deployMyToken = new DeployMyToken();
//         myToken = deployMyToken.run();

//         // Transfer initial balance to Clement from deployer
//         vm.prank(deployerAddress);
//         myToken.transfer(clement, STARTING_BALANCE);
//     }

//     function testInitialSupplyAssignedToDeployer() public {
//         assertEq(myToken.totalSupply(), INITIAL_SUPPLY);
//         assertEq(
//             myToken.balanceOf(deployerAddress),
//             INITIAL_SUPPLY - STARTING_BALANCE
//         );
//     }

//     function testClementTransferToHenry() public {
//         uint256 amount = 10 ether;

//         vm.prank(clement);
//         myToken.transfer(henry, amount);

//         assertEq(myToken.balanceOf(henry), amount);
//         assertEq(myToken.balanceOf(clement), STARTING_BALANCE - amount);
//     }

//     function testTransferExceedsBalance() public {
//         uint256 tooMuch = STARTING_BALANCE + 1 ether;

//         vm.prank(clement);
//         vm.expectRevert(); // Should fail due to insufficient balance
//         myToken.transfer(henry, tooMuch);
//     }

//     function testApproveAndAllowance() public {
//         uint256 allowance = 20 ether;

//         vm.prank(clement);
//         myToken.approve(henry, allowance);

//         assertEq(myToken.allowance(clement, henry), allowance);
//     }

//     function testTransferFrom() public {
//         uint256 allowance = 20 ether;
//         uint256 transferAmount = 5 ether;

//         // Clement approves Henry
//         vm.prank(clement);
//         myToken.approve(henry, allowance);

//         // Henry transfers on behalf of Clement
//         vm.prank(henry);
//         myToken.transferFrom(clement, henry, transferAmount);

//         assertEq(myToken.balanceOf(henry), transferAmount);
//         assertEq(myToken.balanceOf(clement), STARTING_BALANCE - transferAmount);
//         assertEq(myToken.allowance(clement, henry), allowance - transferAmount);
//     }

//     function testTransferFromExceedsAllowance() public {
//         uint256 allowance = 5 ether;
//         uint256 transferAmount = 6 ether;

//         vm.prank(clement);
//         myToken.approve(henry, allowance);

//         vm.prank(henry);
//         vm.expectRevert();
//         myToken.transferFrom(clement, henry, transferAmount);
//     }

//     function testOverwriteAllowance() public {
//         vm.prank(clement);
//         myToken.approve(henry, 5 ether);

//         vm.prank(clement);
//         myToken.approve(henry, 10 ether);

//         assertEq(myToken.allowance(clement, henry), 10 ether);
//     }

//     function testAllowanceDecreasesAfterTransferFrom() public {
//         uint256 allowance = 15 ether;
//         uint256 transferAmount = 10 ether;

//         vm.prank(clement);
//         myToken.approve(henry, allowance);

//         vm.prank(henry);
//         myToken.transferFrom(clement, henry, transferAmount);

//         assertEq(myToken.allowance(clement, henry), allowance - transferAmount);
//     }

//     function testIncreaseDecreaseAllowance() public {
//         // OpenZeppelin ERC20 supports these functions
//         vm.prank(clement);
//         myToken.approve(henry, 5 ether);

//         vm.prank(clement);
//         myToken.increaseAllowance(henry, 3 ether);

//         assertEq(myToken.allowance(clement, henry), 8 ether);

//         vm.prank(clement);
//         myToken.decreaseAllowance(henry, 2 ether);

//         assertEq(myToken.allowance(clement, henry), 6 ether);
//     }
// }

