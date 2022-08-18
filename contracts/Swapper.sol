// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//New swap contract based on Wura's explanation yesterday night - 08/17/22 -8pm WAT

contract Swapper{

    struct Order{
    address ofSwaper;
    address token1;
    address token2;
    uint amountForSwap;
    uint amountDesired;
    bool status;
    // uint price;
    }



    uint ID = 1;

    mapping(uint => Order) public order;

    function createSwapOrder( address fromToken, address toToken, uint _amountForSwap, uint _amountDesired) external{
        require(IERC20(fromToken).transferFrom(msg.sender, address(this), _amountForSwap),"Error: Failed to create order");
        Order storage ORD = order[ID];
        ORD.ofSwaper = msg.sender;
        ORD.token1 = fromToken;
        ORD.token2 = toToken;
        ORD.amountForSwap = _amountForSwap;
        ORD.amountDesired = _amountDesired;
        ORD.status = true;
        ID++;
    }

    function executeSwapOrder(uint _ID) external {
        Order memory ORD = order[_ID];
        assert(ORD.status == true);
        require(IERC20(ORD.token2).transferFrom(msg.sender, address(this), ORD.amountDesired),"Error: Transaction Failed");
        ORD.status = false;
        require(IERC20(ORD.token1).transfer(msg.sender, ORD.amountForSwap), "Error: failed to swap token one");
        require(IERC20(ORD.token2).transfer(ORD.ofSwaper, ORD.amountDesired), "Error: failed to swap token two");

    }

}
