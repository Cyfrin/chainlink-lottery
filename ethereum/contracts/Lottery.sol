pragma solidity ^0.6.6;
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./remix_contracts/RandomNumberGenerator.sol";
import {GovernanceInterface} from "./interfaces/governance.sol";
import {RandomnessInterface} from "./interfaces/randomness.sol";

contract Lottery is ChainlinkClient {
    GovernanceInterface public governanceContract;
    uint256 lotteryId = 0;
    address payable[] public players;
    bool OPEN = true;
    // .01 ETH
    uint256 MINIMUM = 1000000000000000;
    // 0.1 LINK
    uint256 ORACLE_PAYMENT = 100000000000000000;
    // Alarm stuff
    address CHAINLINK_ALARM_ORACLE = 0xc99B3D447826532722E41bc36e644ba3479E4365;
    string CHAINLINK_ALARM_JOB_ID = "0x2ebb1c1a4b1e4229adac24ee0b5f784f";
    //VRF stuff
    bytes32 internal _keyHash;
    uint256 public RANDOMRESULT;
    address public VRFAddress = 0x6ABd8BB710f383E1446882710DE4C2C2b9dbF449;
    RandomNumberGenerator rng;

    constructor() public // VRFConsumerBase(
    //     0xf720CF1B963e0e7bE9F58fd471EFa67e7bF00cfb, // VRF Coordinator
    //     0x20fE562d797A42Dcb3399062AE9546cd06f63280 // LINK Token
    // )
    {
        RandomNumberGenerator rng = RandomNumberGenerator(VRFAddress);
        lotteryId = 1;
        manager = msg.sender;
        _keyHash = 0xced103054e349b8dfb51352f0f8fa9b5d20dde3d06f9f43cb2b85bc64b238205;
        // _fee = 0.1 * 10**18; // 0.1 LINK
        // this is always availible
    }

    function enter() public payable {
        //require(msg.value > MINIMUM);
        assert(msg.value == MINIMUM);
        assert(OPEN == true);
        // could also write:
        // .01 ether
        players.push(msg.sender);
    }

    // function getRandomNumber() private returns (bytes32 requestId) {
    //     uint256 userProvidedSeed = 3453234;
    //     require(
    //         LINK.balanceOf(address(this)) > fee,
    //         "Not enough LINK - fill contract with faucet"
    //     );
    //     return requestRandomness(keyHash, ORACLE_PAYMENT, userProvidedSeed);
    // }

    // /**
    //  * Callback function used by VRF Coordinator
    //  */
    // function fulfillRandomness(bytes32 requestId, uint256 randomness)
    //     external
    //     override
    // {
    //     require(
    //         msg.sender == vrfCoordinator,
    //         "Fulillment only permitted by Coordinator"
    //     );
    //     RANDOMRESULT = randomness;
    //     pickWinner();
    // }

    function start_next_lottery() private {
        Chainlink.Request memory req = buildChainlinkRequest(
            stringToBytes32(CHAINLINK_ALARM_JOB_ID),
            this,
            this.fulfill.selector
        );
        req.addUint("until", now + 5 minutes);
        sendChainlinkRequestTo(CHAINLINK_ALARM_ORACLE, req, ORACLE_PAYMENT);
    }

    function fulfill(bytes32 _requestId)
        public
        recordChainlinkFulfillment(_requestId)
    {
        OPEN = false;
        rng.getRandomNumber(lotteryId);
        lotteryID = lotteryId + 1;
        //start_next_lottery();
        //OPEN = true;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        external
        override
    {
        require(
            msg.sender == vrfCoordinator,
            "Fulfilment only permitted by Coordinator"
        );
        randomResult = randomness;
    }

    function pickWinner() private {
        // assert(msg.sender == manager);
        uint256 index = RANDOMRESULT % players.length;
        players[index].transfer(address(this).balance);
        // returns an adress object
        // all units of transfer are in wei
        players = new address payable[](0);
        // this empties the dynamic array
        start_next_lottery();
        OPEN = true;
    }

    function get_players() public view returns (address payable[] memory) {
        return players;
    }

    function stringToBytes32(string memory source)
        private
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            // solhint-disable-line no-inline-assembly
            result := mload(add(source, 32))
        }
    }
}
