from brownie import accounts, AttackToken,GrimVaultFixed,chain
from brownie.network import priority_fee
from rich import print as rp

def main():
    priority_fee('auto')
    grimfixed=GrimVaultFixed.deploy({'from':accounts[0]})
    attk=AttackToken.deploy(grimfixed,{'from':accounts[0]})
    rp('[bold green]------> Step 1: Call depositFor function of fixed contract which should result in error')
    attk.attack()
