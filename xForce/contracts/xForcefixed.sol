pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./token.sol";

contract xforcefix is ERC20{
forceToken public force;

constructor(address payable forcetoken) public ERC20("xforce", "XFE") { 
    force=forceToken(forcetoken);
}


function deposit(uint256 amount) external{
    mint(msg.sender,amount);
    if(force.transferFrom(msg.sender,address(this),amount)==false){
        revert();
        }
}    


function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
    
receive() external payable {
    
}


}