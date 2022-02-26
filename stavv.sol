//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// - You are all to build a proof of existence contract,
// borrowing from the concepts we have been learning since the classes began.
// You are welcome to come up with any Idea as long as it can prove the existence of something.




// this is a proof existence for staffs of a company,
// only the Hr Manager can onboard staffs, only the Hr manager can remove a staff


// Lets start cooking ):

contract Staffs{

    
    address owner;
    address Hr_manager;
    


    constructor(address CEO, address _Hr_manager){
         owner = CEO;
         Hr_manager = _Hr_manager;
    }


    // Only the CEO and Hr_manager can add a staff

    modifier higherOrder(){
        require(msg.sender == owner || msg.sender == Hr_manager,"You are not authorized to perform this task");
        _;
    }


    struct Experience{
        string[] companies;
        string year;


    }

    struct Staff_details{
        string name;
        uint age;
        uint DOB;
        string qualification;
        string state;
        uint[] experienceIDs;        
        mapping(uint => Experience) Experiences;
    }

     struct Staff_details_Demo{
        string name;
        uint age;
        uint DOB;
        string qualification;
        string state;
        Experience exp;
    }


    
    uint public Index;
    mapping(uint => Staff_details)public Staff_infos;
    mapping(uint => Staff_details_Demo) Staff_information;
    mapping (uint => Experience) experiencesStore;

    function addStaff(string memory _name, uint _age, uint _DOB, string memory _qualification, string memory _state) public{
        Staff_details storage staff = Staff_infos[Index];
        staff.name = _name;
        staff.age = _age;
        staff.DOB = _DOB;
        staff.qualification = _qualification;
        staff.state = _state;
        Index++;

    }


    function fetchStaffDetails(uint idNumber)public view returns(Staff_details_Demo memory info){
        Staff_details storage staff = Staff_infos[idNumber];

        info.name= staff.name;
        info.age = staff.age;
        info.DOB = staff.DOB;
        info.qualification = staff.qualification;
        info.state = staff.state;
        info.exp = staff.Experiences[idNumber];
    }

    function viewAllStaffs(uint staffAmount)public view returns(Staff_details_Demo[] memory all){
        require(staffAmount <= Index, "wrong input");
        all = new Staff_details_Demo[](staffAmount);
        for(uint i = 0; i < staffAmount; i++){
            all[i] = Staff_information[i];
        }
        return all;
    }
     
    function random() internal view returns(uint){
       return uint (keccak256(abi.encodePacked(block.difficulty, block.timestamp, Index )));
    }

    function pickWinner()public view returns (uint){
        uint luckyNumber = random() % Index;
        return luckyNumber;
    }

    function experienceDetails(uint id, string[] memory _company, string memory _year) external {
        Staff_details storage staff = Staff_infos[id];
        // staff.Experiences[id];
        Experience storage staff_exp = staff.Experiences[id];
        staff_exp.companies = _company;
        staff_exp.year = _year;
    }
}