pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";

contract forceToken is ERC20{

constructor() public ERC20("force", "FCE") { 
}


function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        if (allowance(sender,msg.sender) < amount)
                return false;
        _transfer(sender, recipient, amount);
        
        return true;
    }    


function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
    
receive() external payable {
    
}


}
