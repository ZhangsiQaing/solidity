// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract BinarySearch {
    function search(int256[] calldata _arr,int256  target) public pure returns(int256) {
        uint256 left = 0;
        uint256 right = _arr.length;
        int256 index = -1;
        while(left < right) {
            uint256 mid = (left+right)/2;
            if(_arr[mid] > target){
                right = mid - 1;
            }else if (_arr[mid] < target){
                left = mid + 1;
            }else {
                index = int256(mid);
                break;
            }
        }
        return index;
    }
}