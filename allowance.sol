pragma solidity 0.6.0 <=0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    mapping(address =>uint256) public allowance;
    
    event ALlowanceChange(address indexed _who, address indexed _whom,uint256 _oldamount,uint256 _newamount);
  
    function isowner() public view returns(bool) {
        return(owner()== msg.sender);
    }
    
    modifier ownerorallowance(uint256 _amount){
        require(isowner()||allowance[msg.sender] >=_amount,"You Don't Have Enough Funds");
        _;
    }
    
    
    function SetAllowance(address _who,uint256 _amount) public onlyOwner{
        emit ALlowanceChange(_who,msg.sender,allowance[_who],_amount);
        allowance[_who]=_amount;
    }
    
    function reduceallowance(address _Who,uint256 _amount) internal ownerorallowance(_amount){
        emit ALlowanceChange(_Who,msg.sender,allowance[_Who],allowance[_Who]-_amount);
        allowance[_Who]-=_amount;
    }
}