pragma solidity 0.6.6;

interface GovernanceInterface {
    function lottery() external view returns (address);

    function randomness() external view returns (address);
}
