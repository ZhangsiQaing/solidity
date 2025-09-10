// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyERC20 {

    //总供应量
    uint256 public _totalSupply;
    //代币名称
    string private _name;
    //代币符号
    string private _symbol;

    //账户所有者
    address public immutable owner;

    modifier OnlyOwner(){
        require(msg.sender == owner,"address not allow");
        _;
    }

    //转账日志
    event Transfer(address indexed from, address indexed to, uint256 value);
    //授权日志
    event Approval(address indexed owner, address indexed spender, uint256 value);

    //账户余额
    mapping(address => uint256) private _balance;
    //授权
    mapping(address => mapping(address spender => uint256)) private _allowances;

    //查询账户余额
    function balanceOf(address account) public view returns (uint256) {
        return _balance[account];
    }


    constructor(string memory name_,string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        owner = msg.sender;
    }

    //增发代币
    function mint(address to,uint256 amount) external OnlyOwner {
        _mint(to,amount);
    }

    function _mint(address to,uint256 amount) private {
        require(to != address(0),"ERC20: to zero");
        _totalSupply += amount;
        _balance[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    //转账
    function transfer(address from,address to,uint256 amount) public returns(bool) {
        _transfer(from, to, amount);
        return true;
    }

    //转帐内部逻辑
    function _transfer(address from,address to,uint256 amount) internal {
        // address owner = _msgSpender();
        if (from == address(0)){ revert("from address is Invalid");}
        if (to == address(0)) {revert("to address is Invalid");}

        uint256 formBalance = _balance[from];
        //转账账户账户金额是否充足
        if (formBalance < amount){
            revert("formBalance is Insufficient");
        }
        unchecked {
            _balance[from] = formBalance - amount;
            _balance[to] += amount;
        }

        emit Transfer(from,to,amount);
    }

    // 授权
    function approve(address spender,uint256 amount) public returns (bool) {
        address approveOwner = _msgSpender();
        _approve(approveOwner, spender, amount);
        return true;
    }

    // 授权内部方法
    function _approve(address approveOwner,address spender,uint256 amount) internal {
        if (approveOwner == address(0)) { revert(); }
        if (spender == address(0)) { revert(); }
        _allowances[approveOwner][spender] = amount;
    }

    // 代扣转帐逻辑
    // 1、先判断账户时候是否有代扣权限
    // 2、执行转帐逻辑
    //    更新账户金额
    //    更新代扣金额
    // from //账户原有者
    // to //账户接收者
    function transferFrom(address from,address to,uint256 amount) public returns(bool) {
        address spender = _msgSpender();
        _spendAllowance(from,spender,amount);
        _transfer(from, to, amount);
        return true;
    }

    //判断是否有代扣权限，并扣减金额
    function _spendAllowance(address from,address spender,uint256 amount) internal {
        uint256 allowAmount = _allowances[from][spender];
        if (allowAmount < type(uint256).max) {
            if (allowAmount < amount) { revert("spender money is Insufficient"); }
            unchecked {
                _approve(from,spender,allowAmount - amount);
            }
        }
    }



    //获取调用者地址
    function _msgSpender() internal view returns(address)  {
        return msg.sender;
    }

}