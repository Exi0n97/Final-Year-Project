pragma solidity ^0.8.0;

import "./openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./openzeppelin/contracts/utils/math/SafeMath.sol";


contract GrimVaultFixed is ERC20{
    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    bool private lock=false;

constructor() public ERC20("Grim", "GRM") { }

function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

function depositFor(address token, uint256 _amount, address user) public{
    require(!lock);
    lock=true;
    uint256 before=IERC20(token).balanceOf(address(this));
    IERC20(token).safeTransferFrom(msg.sender,address(this),_amount);
    uint256 post=IERC20(token).balanceOf(address(this));
    lock=false;
    _amount=post.sub(before);
    _mint(user,_amount);
}


receive() external payable {}
}