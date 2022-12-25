// SPDX_License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;
contract lottery{
    address public manager ;
    address payable[] public players;
    constructor(){
        manager = msg.sender;
    }
    receive() external payable{
        require(msg.value==1 ether);
        players.push(payable(msg.sender));
    }
    function getbalance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }
    function randomplayer() public view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));

    }
    function winner() public{
        require(msg.sender==manager);
        require(players.length >= 3);
        uint r = randomplayer();
        address payable winnerr;
        uint index = r % players.length;
        winnerr = players[index];
        winnerr.transfer(getbalance());
        players = new address payable[](0);//removes all the players form contract
    }
}