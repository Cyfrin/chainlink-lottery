import React, { Component } from "react";
import logo from "./logo.svg";
import "./App.css";
import web3 from "./web3";
import lottery from "./lottery";
import { render } from "@testing-library/react";

class App extends Component {
  // constructor(props) {
  //   super(props);
  //   this.state = { manager: "" };
  // }
  state = {
    lottery_state: 1,
    players: [],
    message: "",
    value: ""
    //balance: ""
  };
  //web3.eth.getAccounts().then(console.log)
  async componentDidMount() {
    //console.log()
    const lottery_state = await lottery.methods.lottery_state().call();
    this.setState({ lottery_state: lottery_state });
    const players = await lottery.methods.get_players().call();
    const pot = await lottery.methods.get_pot().call();
    //this.setState({ manager, players });
  }

  // onSubmit() {}
  onSubmit = async event => {
    event.preventDefault();
    let accounts;
    try {
      accounts = await window.ethereum.enable();
    } catch (error) {
      console.log(error);
    }

    this.setState({ message: "Waiting on transactions success...." });
    // console.log(accounts[0]);
    console.log(web3.utils.toWei(this.state.value, "ether"));
    // console.log(web3);
    // console.log(lottery);
    await lottery.methods.enter().send({
      from: accounts[0],
      value: web3.utils.toWei(this.state.value, "ether")
    });
    this.setState({ message: "You have successfully been entered" });
    // const transactionParameters = {
    //   to: lottery.options.address, // Required except during contract publications.
    //   from: accounts[0], // must match user's active address.
    //   value: web3.utils.toWei(this.state.value, "ether") // Only required to send ether to the recipient from the initiating external account.
    // };
    // await window.ethereum.sendAsync({
    //   method: "eth_sendTransaction",
    //   params: [transactionParameters]
    // });
  };
  onClick = async event => {
    event.preventDefault();
    let accounts;
    try {
      accounts = await window.ethereum.enable();
    } catch (error) {
      console.log(error);
    }
    // 0x5036F68EFAE0F4729789684bdbD506FBEe68d250
    // 0x5036f68efae0f4729789684bdbd506fbee68d250
    if (
      accounts[0].toString().toLowerCase() ==
      this.state.manager.toString().toLowerCase()
    ) {
      this.setState({ message: "Picking winner...." });
      await lottery.methods.pickWinner().send({
        from: accounts[0]
      });
      this.setState({ message: "Winner was picked!!" });
    } else {
      this.setState({ message: "You have to be manager silly" });
    }
  };
  //This means you don't have to do 'this' keyword
  render() {
    return (
      <div>
        <h2>Lottery Contract</h2>
        <p> This contract is managed by {this.state.manager}</p>
        <p>
          There are currently {this.state.players.length} players in this
          contest.
          {/* Competing to win
          {web3.utils.fromWei(this.state.balance, "ether")} ether
          */}
        </p>
        <hr />
        <form onSubmit={this.onSubmit}>
          <h4>Want to try you're luck?</h4>
          <div>
            <label> Amount of ether to enter</label>
            <input
              value={this.state.value}
              onChange={event => this.setState({ value: event.target.value })}
            ></input>
          </div>
          <button> Enter</button>
        </form>
        <h1> {this.state.message}</h1>
        <hr />
      </div>
    );
  }
}
export default App;
