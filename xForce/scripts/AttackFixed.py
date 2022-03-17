from brownie import accounts, xforcefix, xforce, forceToken, chain
from brownie.network import priority_fee
from rich import print as rp


def main():
    priority_fee('auto')
    forcet=forceToken.deploy({'from':accounts[0]})
    xforcefixed=xforcefix.deploy(forcet,{'from':accounts[0]})
    rp('[bold green]------> Step 1: Call deposit function of fixed contract which should result in reverted transaction')
    xforcefixed.deposit(100,{'from':accounts[0]})
    rp(f'[bold]Balance of account after calling deposit is: [/] {xforcefixed.balanceOf(accounts[0])}')




