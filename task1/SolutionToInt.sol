// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract SolutionToInt {

    mapping(bytes1=>uint256) public rm;

    constructor() {
        rm[bytes1("I")] = 1;
        rm[bytes1("V")] = 5;
        rm[bytes1("X")] = 10;
        rm[bytes1("L")] = 50;
        rm[bytes1("C")] = 100;
        rm[bytes1("D")] = 500;
        rm[bytes1("M")] = 1000;
    }

    function revers1(string memory _st) public view returns(uint256) {
        
        uint256 res = 0;
        bytes memory bytesStr = bytes(_st);

        for (uint256 i =0;i<bytesStr.length;i++){
            if (i < bytesStr.length - 1 && bytesStr[i] == bytes1("I") && (bytesStr[i+1] == bytes1("V") || bytesStr[i+1] == bytes1("X"))) {
                res = res + rm[bytesStr[i+1]] - rm[bytesStr[i]];
                i++;
                continue;
            }
            if (i < bytesStr.length - 1 && bytesStr[i] == bytes1("X") && (bytesStr[i+1] == bytes1("L") || bytesStr[i+1] == bytes1("C"))) {
                res = res + rm[bytesStr[i+1]] - rm[bytesStr[i]];
                i++;
                continue;
            }
            if (i < bytesStr.length - 1 && bytesStr[i] == bytes1("C") && (bytesStr[i+1] == bytes1("D") || bytesStr[i+1] == bytes1("M"))) {
                res = res + rm[bytesStr[i+1]] - rm[bytesStr[i]];
                i++;
                continue;
            }
            res += rm[bytesStr[i]];
        }
        return res;
    }
    

    function revers2(string memory _st) public view returns(uint256) {
        
        uint256 res = 0;
        bytes memory bytesStr = bytes(_st);

        for (uint256 i =0;i<bytesStr.length;i++){
            bytes1 current = bytesStr[i];

            if (i < bytesStr.length - 1) {
                bytes1 next = bytesStr[i+1];
                if (current == bytes1("I") && (next == bytes1("V") || next == bytes1("X"))) {
                    res = res + rm[next] - rm[current];
                    i++;
                    continue;
                }
                if (current == bytes1("X") && (next == bytes1("L") || next == bytes1("C"))) {
                    res = res + rm[next] - rm[current];
                    i++;
                    continue;
                }
                if (current == bytes1("C") && (next == bytes1("D") || next == bytes1("M"))) {
                    res = res + rm[next] - rm[current];
                    i++;
                    continue;
                }
            }
            res += rm[current];
        }
        return res;
    }

}