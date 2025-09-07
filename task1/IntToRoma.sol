// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract IntToRoma{
    uint256[] private number = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    string[] private RomaString = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"];

    function intToRoma(uint256 num) public view returns(string memory){
        // require(condition);
        bytes memory result = "";

        for (uint256 i=0;i<number.length;i++){
            while(num >= number[i]){
                result = abi.encodePacked(result,RomaString[i]);
                num -= number[i];
            }
        }

        return string(result);
    }

}