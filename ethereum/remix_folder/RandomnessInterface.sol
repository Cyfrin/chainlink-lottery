pragma solidity 0.6.6;

interface RandomnessInterface {
    function randomNumber(uint256) external view returns (uint256);

    function getRandom(uint256, uint256) external;
}
