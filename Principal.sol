// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract ProofOfExistence{

    struct StudentRec{
        uint ID;
        string fullname;
        uint DOB;
        string gender;
        string stateoforigin;
    }

    uint ID = 1000;
    address admin;

    mapping (address => uint) private studentsId;
    mapping (uint => StudentRec) internal IDToRecords;

    StudentRec[] studentsRecords;

    constructor(address _admin){
        admin = _admin;
    }

   

    modifier onlyAdmin{
        require(msg.sender == admin, "only admin can call this");
        _;
    }

    function addStudent(address _address, string memory _fullname,  
        uint _DOB, string memory _gender, string memory _stateoforigin
        )
        public onlyAdmin returns (bool, uint){
            if(addressExist(_address)){
                return (false, 0);
            }
             ID = ID + 1;
            StudentRec memory newStudent = StudentRec(ID, _fullname, _DOB, _gender, _stateoforigin);
            studentsRecords.push(newStudent);
            studentsId[_address] = ID;
            IDToRecords[ID] = newStudent;
            return (true, ID);
    }

    function retrieveID()external view returns(bool, uint256){
        uint id = studentsId[msg.sender];
        if(id == 0) return (false, 0);
        return (true, id);
    }

    function adminRecovery(address _address)onlyAdmin external view returns(bool, uint256){
        uint id = studentsId[_address];
        if(id == 0) return (false, 0);
        return (true, id);
    }

    function confirmRecord(uint256 _ID) external view returns(StudentRec memory){
        return IDToRecords[_ID];
    }

    function addressExist(address _address)internal view returns(bool){
        return !(studentsId[_address] == 0);
    }
}