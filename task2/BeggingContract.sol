// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract BeggingContract{

    mapping(address => uint256) public donators;

    address public immutable owner;

    //开始时间
    uint256 deploymentTimestamp;
    //锁定时间
    uint256 lockTime;

    struct Donor {
        address addr;
        uint256 amount;
    }

    Donor[3] public top3; // 实时缓存前三名

    constructor(uint256 _lockTime){
        owner = msg.sender;
        deploymentTimestamp = block.timestamp;
        lockTime = _lockTime;
    }

    //捐赠事件
    event Donation(address indexed donator,uint256 amount);

    //只有合约所有者才能操作
    modifier OnlyOwner() {
        require(msg.sender == owner,"address is not allow");
        _;
    }

    //接收以太币
    function donate() public payable {
        require(block.timestamp < deploymentTimestamp + lockTime,"window is closed");
        donators[msg.sender] += msg.value;
        emit Donation(msg.sender,msg.value);
        _updateTop3(msg.sender, donators[msg.sender]);
    }

    //合约所有者提取所有资金
    function withdraw() public payable OnlyOwner {
        uint256 totalAmount = address(this).balance;
        require(totalAmount > 0,"balance is empty");
        payable(msg.sender).transfer(totalAmount);
    }

    //查询资金
    function getDonation(address addr) public view returns(uint256) {
        return donators[addr];
    }


    // 获取前三名（地址和金额）
    function getTop3() public view returns (address[3] memory addrs, uint256[3] memory amounts) {
        for (uint256 i = 0; i < 3; i++) {
            addrs[i] = top3[i].addr;
            amounts[i] = top3[i].amount;
        }
    }


    function _updateTop3(address donor, uint256 amount) internal {
        // 如果已经在 top3 里，直接更新
        for (uint256 i = 0; i < 3; i++) {
            if (top3[i].addr == donor) {
                top3[i].amount = amount;
                _reorderTop3();
                return;
            }
        }

        // 如果不在 top3，检查是否能挤进来
        for (uint256 i = 0; i < 3; i++) {
            if (amount > top3[i].amount) {
                // 把后面的往下挪
                for (uint256 j = 2; j > i; j--) {
                    top3[j] = top3[j-1];
                }
                top3[i] = Donor(donor, amount);
                break;
            }
        }
    }

    function _reorderTop3() internal {
        for (uint256 i = 0; i < 2; i++) {
            for (uint256 j = i+1; j < 3; j++) {
                if (top3[j].amount > top3[i].amount) {
                    Donor memory tmp = top3[i];
                    top3[i] = top3[j];
                    top3[j] = tmp;
                }
            }
        }
    }
}