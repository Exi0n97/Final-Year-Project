pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./eth.sol";
import "./usd.sol";

contract Dex{
 etherToken public eth;
 usdToken public usd;

constructor(address payable ethtoken,address payable usdtoken) public { 
    eth=etherToken(ethtoken);
    usd=usdToken(usdtoken);
    eth.mint(address(this),800);
    usd.mint(address(this),3200);

}

function tradeEth(address account, uint256 amount) external {
        eth.transferFrom(address(this),account,amount);
    }

function tradeUSD(address account, uint256 amount) external {
        usd.transferFrom(address(this),account,amount);
    }


receive() external payable {}
}