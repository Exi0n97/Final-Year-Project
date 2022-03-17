pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./eth.sol";
import "./usd.sol";

contract Loaner{
etherToken eth;
usdToken usd;

constructor(address payable ethtoken,address payable usdtoken) public { 
    eth=etherToken(ethtoken);
    usd=usdToken(usdtoken);
    eth.mint(address(this),100000);
    usd.mint(address(this),100000);
}


function lendeth(address account, uint256 amount) external {
        eth.transferFrom(address(this),account,amount);
    }

function lendusd(address account, uint256 amount) external {
        usd.transferFrom(address(this),account,amount);
    }

receive() external payable {}
}