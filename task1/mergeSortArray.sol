// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract mergeSortArray {

    function mergeArr(int256[] calldata _arr1,int256[] calldata _arr2) public pure returns(int256[] memory){
        int256[] memory arr = new int256[](_arr1.length+_arr2.length);
        uint256 i=0;
        uint256 j=0;
        uint256 arrindex = 0;
        while(i<_arr1.length && j<_arr2.length) {
            if (_arr1[i] <= _arr2[j]){
                arr[arrindex++] = _arr1[i++];
            } else {
                arr[arrindex++] = _arr2[j++];
            }
        }


        while(i<_arr1.length){
            arr[arrindex++] = _arr1[i++];
        }

        while(j<_arr2.length){
            arr[arrindex++] = _arr2[j++];
        }

        return arr;
    }


}