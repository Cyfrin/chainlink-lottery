import Web3 from "web3";

let web3;
if (
    window.ethereum.isMetaMask &&
    (typeof window.ethereum !== "undefined" || typeof window.web3 !== "undefined")
) {
    web3 = new Web3(window.ethereum) || window.web3.currentProvider;
}

export default web3;
