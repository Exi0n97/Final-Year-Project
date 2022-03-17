from brownie import accounts, xforcefix, xforce, forceToken, chain
from brownie.network import priority_fee
from rich import print as rp


def main():
    priority_fee('auto')
    forcet=forceToken.deploy({'from':accounts[0]})
    xforcet=xforce.deploy(forcet,{'from':accounts[0]})
    xforcefixed=xforcefix.deploy(forcet,{'from':accounts[0]})
    rp('[bold green]------> Step 1: Call deposit function of vulnerable contract')
    xforcet.deposit(100,{'from':accounts[0]})
    rp(f'[bold]Balance of account after calling deposit is: [/] {xforcet.balanceOf(accounts[0])}')
    rp('[bold green]------> Step 2: Call deposit function of fixed contract which should result in reverted transaction')
    xforcefixed.deposit(100,{'from':accounts[1]})




