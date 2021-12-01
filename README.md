## How to setup

- Install `truffle`, `geth` command.
- Install Ganache desktop GUI and launch a `quick start` blockchain instance.

## Deploy

- Configure `truffle-config.js`, networks -> development section for the network you want to connect to. You don't need to change that if you connects to your local instance.

```
development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
```

- Run `truffle console` to login to truffle console.

- Run 

```
> migrate # deploy contracts from `contracts` folder to your local blockchain.
> let ledger = await Ledger.deployed()
> let accounts = await web3.eth.getAccounts()
> (await ledger.getBalance(accounts[0])).toNumber() # get the account0 balance
> (await ledger.getBalance(accounts[1])).toNumber() # get the account1 balance
> ledger.sendCoin(accounts[1], {from: accounts[0], value: 10}) # transfer 10 zeller coins from account0 to account1, it should print out the tranaction log in the console.
> run the get balance command again to see the balance is changed.
```
