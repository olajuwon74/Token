//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// - You are all to build a proof of existence contract,
// borrowing from the concepts we have been learning since the classes began.
// You are welcome to come up with any Idea as long as it can prove the existence of something.




// this is a proof existence for staffs of a company,
// only the Hr Manager can onboard staffs, only the Hr manager can remove a staff
// staffs have a leader board where they are ranked according to how they work hard, the Hr
// is in charge of this also

// Lets start cooking

contract Proof_of_existence{

    address owner;
    address Hr_manager;
    


    constructor(address CEO, address _Hr_manager){
         owner = CEO;
         Hr_manager = _Hr_manager;
    }

    modifier higherOrder(){
        require(msg.sender == owner || msg.sender == Hr_manager,"You are not authorized to perform this task");
        _;
    }

     modifier onlyCEO(){
        require(msg.sender == owner,"You are not authorized to perform this task");
        _;
    }

    struct Staff_details{
        string name;
        uint age;
        uint DOB;
        string qualification;
        string state;
        uint Id;
    }
    
    uint _Id;
    Staff_details[] public staff_details;
    

     mapping(uint => Staff_details)public Staff_Info;

    //  Staff_Info[Id]

    function addStaff (string memory _name,uint _age, uint _DOB,string memory _qualification,string memory _state) public higherOrder {
        _Id++;
        staff_details.push(Staff_details(_name, _age, _DOB, _qualification, _state, _Id));
        Staff_Info[_Id] = Staff_details(_name, _age, _DOB, _qualification, _state, _Id);
    }
   function deleteStaff(uint _id) public {
       staff_details[_id];
       for (uint i = _id; i < staff_details.length - 1 ; i++){
           staff_details[i] = staff_details[i + 1];
       }
       staff_details.pop();
   }
         

}