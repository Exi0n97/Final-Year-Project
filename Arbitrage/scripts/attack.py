from brownie import accounts, etherToken , usdToken, Dex1, Dex2,exploiter, chain
from brownie.network import priority_fee
from rich import print as rp


def main():
    priority_fee('auto')
    eth=etherToken.deploy({'from':accounts[0]})
    usd=usdToken.deploy({'from':accounts[0]})
    dex1=Dex1.deploy(eth,usd,{'from':accounts[0]})
    dex2=Dex2.deploy(eth,usd,{'from':accounts[0]})
    atk=exploiter.deploy(eth,usd,dex1,dex2,{'from':accounts[0]})
    before=usd.balanceOf(atk)
    rp('[bold green]------ Exploit: Arbitrage ------------[/]')
    rp('[bold green]------> Step 1: Compare DEX prices for a token pair, in this case USDT/ETH pair')
    Dex1Ethprice=float(usd.balanceOf(dex1)/eth.balanceOf(dex1))
    Dex1Usdprice=float(eth.balanceOf(dex1)/usd.balanceOf(dex1))
    rp(f'[bold]current rate for dex1 per usd token is: [/] {Dex1Ethprice}')
    Dex2Ethprice=float(usd.balanceOf(dex2)/eth.balanceOf(dex2))
    Dex2Usdprice=float(eth.balanceOf(dex2)/usd.balanceOf(dex2))
    rp(f'[bold]current rate for dex2 per usd token is: [/] {Dex2Ethprice}')
    rp('[bold green]------> Step 2: Buy eth tokens using usd from cheaper DEX')
    atk.buyethfromdex1(3000)
    amounttobuy=int(3000*Dex1Usdprice)
    dex1.tradeEth(atk,amounttobuy)
    rp('[bold green]------> Step 3: Sell eth tokens for usd from more expensive DEX')
    atk.sellethtodex2(amounttobuy)
    dex2.tradeUSD(atk,int(amounttobuy*Dex2Ethprice))
    profit=usd.balanceOf(atk)-before
    rp(f'[bold]gained [/] {profit} usd tokens')