// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Votting {

    mapping(string => uint256) public votes;
    mapping(string => bool) public isCandidate;
    string[] public candidateList; 

    //用来投票
    function vote(string calldata _name) public {
        votes[_name] += 1;
        if (isCandidate[_name] == false) {
            candidateList.push(_name);
        }
    }

    //返回候选人票数
    function getVotes(string calldata _name) public view returns(uint256) {
        return votes[_name];
    }



    //重制所有候选人票数
    function resetVotes() public {
        for (uint256 i=0;i<candidateList.length;i++) {
            votes[candidateList[i]] = 0;
        }
    }

}