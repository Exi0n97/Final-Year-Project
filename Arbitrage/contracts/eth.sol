pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";

contract etherToken is ERC20{

constructor() public ERC20("ETH", "ETH") { }

function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _mint(recipient,amount);
        _burn(sender,amount);
        
        return true;
    } 

function mint(address receiver, uint256 amount) external {
        _mint(receiver, amount);
    }

receive() external payable {}
}