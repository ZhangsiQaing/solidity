contract Reverse {
    function re(string memory st) public pure returns(string memory) {
        bytes memory byst = bytes(st);
        bytes memory byst2 = new bytes(byst.length);
        for(uint256 i=0;i<byst.length;i++){
            byst2[i] = byst[byst.length-1-i];
        }
        return string(byst2);
    }
}