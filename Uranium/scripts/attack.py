from brownie import accounts, FlashMinter, FlashBorrower,chain
from brownie.network import priority_fee
from rich import print as rp

def main():
    priority_fee('auto')
    lender=FlashMinter.deploy("dai","dai",10,{'from':accounts[0]})
    borrower=FlashBorrower.deploy(lender, {'from':accounts[0]})
    borrower.flashBorrow(lender,500)
    rp(f'[bold]Balance of borrower after calling loan is: [/] {lender.balanceOf(borrower)}')
    rp(f'[bold]Amount flash loaned to borrower is: [/] {borrower.checkBorrowed()}')


