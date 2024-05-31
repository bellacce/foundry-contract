// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// import "lib/chainlink/contracts/src/v0.8/vrf/VRFConsumerBase.sol"; // 使用Chainlink VRF
import "@chainlink/src/v0.8/vrf/VRFConsumerBaseV2.sol";
// import "lib/chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";

contract Lottery is VRFConsumerBase {
    address public owner;
    address[] public players;
    uint256 public lotteryEndTime;
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public winner;

    constructor(address _vrfCoordinator, address _linkToken, bytes32 _keyHash, uint256 _fee)
        VRFConsumerBase(_vrfCoordinator, _linkToken)
    {
        owner = msg.sender;
        keyHash = _keyHash;
        fee = _fee;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier lotteryEnded() {
        require(block.timestamp >= lotteryEndTime, "Lottery not ended yet");
        _;
    }

    function startLottery(uint256 _duration) public onlyOwner {
        require(lotteryEndTime == 0 || block.timestamp >= lotteryEndTime, "Lottery already running");
        lotteryEndTime = block.timestamp + _duration;
        delete players;
        delete winner;
        randomResult = 0;
    }

    function enter() public payable {
        require(block.timestamp < lotteryEndTime, "Lottery ended");
        require(msg.value > 0.01 ether, "Minimum ETH not met");
        players.push(msg.sender);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
        pickWinner();
    }

    function requestRandomWinner() public onlyOwner lotteryEnded {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK");
        requestRandomness(keyHash, fee);
    }

    function pickWinner() private {
        require(randomResult > 0, "Randomness not set");
        uint256 index = randomResult % players.length;
        winner = players[index];
        payable(winner).transfer(address(this).balance);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function getWinner() public view returns (address) {
        return winner;
    }

    receive() external payable {}
}
