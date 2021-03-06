pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC3156FlashBorrower.sol";
import "./IERC3156FlashLender.sol";


contract FlashBorrower is IERC3156FlashBorrower {
    enum Action {NORMAL, OTHER}
    uint256 public borrowed;
    IERC3156FlashLender lender;

    constructor (
        IERC3156FlashLender lender_
    ) {
        lender = lender_;
        borrowed = 0;
    }

function onFlashLoan(
    address initiator,
    address token,
    uint256 amount,
    uint256 fee,
    bytes calldata data
) external override returns(bytes32) {
    require(
        msg.sender == address(lender),
        "FlashBorrower: Untrusted lender"
    );
    require(
        initiator == address(this),
        "FlashBorrower: Untrusted loan initiator"
    );
    
    // optionally check data here if wanted

    return keccak256("ERC3156FlashBorrower.onFlashLoan");
}

    /// @dev Initiate a flash loan
    function flashBorrow(
        address token,
        uint256 amount
    ) public {
        bytes memory data = abi.encode(Action.NORMAL);
        uint256 _allowance = IERC20(token).allowance(address(this), address(lender));
        uint256 _fee = lender.flashFee(token, amount);
        uint256 _repayment = amount + _fee;
        _repayment=_repayment/100;
        IERC20(token).approve(address(lender), _allowance + _repayment);
        lender.flashLoan(this, token, amount, data);
        borrowed=borrowed+amount;
    }

    function checkBorrowed() public view returns (uint256){
        return borrowed;
    }
}