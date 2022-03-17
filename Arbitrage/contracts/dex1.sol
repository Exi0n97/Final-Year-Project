pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./openzeppelin/contracts/utils/math/SafeMath.sol";
import "./eth.sol";
import "./usd.sol";

contract Dex1{
using SafeMath for uint256;
 etherToken public eth;
 usdToken public usd;

constructor(address payable ethtoken,address payable usdtoken) public { 
    eth=etherToken(ethtoken);
    usd=usdToken(usdtoken);
    eth.mint(address(this),100000);
    usd.mint(address(this),150000);

}

function tradeEth(address account, uint256 amount) external {
        eth.transferFrom(address(this),account,amount);
    }

function tradeUSD(address account, uint256 amount) external {
        usd.transferFrom(address(this),account,amount);
    }


receive() external payable {}
}