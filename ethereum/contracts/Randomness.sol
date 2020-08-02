pragma solidity ^0.6.6;

import {GovernanceInterface} from "./interfaces/governance.sol";
import {VRFConsumerBase} from "./vrf/VRFConsumerBase.sol";

//     0x20fE562d797A42Dcb3399062AE9546cd06f63280 // LINK Token

contract Randomness is VRFConsumerBase {
    address public VRF_COORDINATOR = 0xf720CF1B963e0e7bE9F58fd471EFa67e7bF00cfb;
    address public LINK_TOKEN = 0x20fE562d797A42Dcb3399062AE9546cd06f63280;
    uint256 ORACLE_PAYMENT = 100000000000000000;
    bytes32
        internal KEYHASH = 0xced103054e349b8dfb51352f0f8fa9b5d20dde3d06f9f43cb2b85bc64b238205;

    GovernanceInterface public governanceContract;
    // Mapping of lottery id => randomness number
    mapping(uint256 => uint256) public randomNumber;
    mapping(bytes32 => uint256) public requestIds;

    constructor(address _governance)
        public
        VRFConsumerBase(VRF_COORDINATOR, LINK_TOKEN)
    {
        governanceContract = GovernanceInterface(_governance);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        external
        override
    {
        require(vrfCoordinator == msg.sender, "not-vrf-coordinator");
        require(requestIds[requestId] != 0, "request-id-not-vaild");
        uint256 lotteryId = requestIds[requestId];
        randomNumber[lotteryId] = randomness;
    }

    function getRandom(uint256 lotteryId, uint256 seed) external {
        require(randomNumber[lotteryId] == 0, "Already-found-random");
        require(
            governanceContract.lottery() == msg.sender,
            "not-lottery-address"
        );
        // LINK.transferFrom(
        //     governanceContract.admin(),
        //     address(this),
        //     ORACLE_PAYMENT
        // );
        require(
            LINK.balanceOf(address(this)) > ORACLE_PAYMENT,
            "Not enough LINK - fill contract with faucet"
        );

        bytes32 _requestId = requestRandomness(KEYHASH, ORACLE_PAYMENT, seed);
        requestIds[_requestId] = lotteryId;
    }
}
