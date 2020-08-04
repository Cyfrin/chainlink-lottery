pragma solidity 0.6.6;

interface Randomness_interface {
    function randomNumber(uint) external view returns (uint);
    function getRandom(uint, uint) external;
}