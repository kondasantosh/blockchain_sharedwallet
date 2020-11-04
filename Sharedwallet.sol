pragma solidity 0.6.0 <=0.7.0;

import "./allowance.sol";

contract sharedwallet is Allowance{
    
    event moneysend(address indexed _beneficicary,uint256 _amount);
    event moneyReceived(address indexed _from,uint256 _amount);
    function withdraw(address payable _to,uint256 _amount) public {
        require(_amount<= address(this).balance,"Contract does'nt own enough money");
        if(!isowner()){
            reduceallowance(msg.sender, _amount);
        }
        emit moneysend(_to,_amount);
        _to.transfer(_amount);
    }
    
    function renounceownership() public onlyOwner{
        revert("can't renounceownership here");
    }
    
    
    receive() external payable{
        emit moneyReceived(msg.sender,msg.value);
    }
}