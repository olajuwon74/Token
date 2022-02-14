// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


// create a special kind of meal for different types of people with respect to 
// their health status and age group and body goals

contract FoodType{


    enum Range{
        Child,
        Young,
        Middleaged,
        Old
    }
   
    mapping(Range => string) rangeValue;

    mapping(address => uint) addresses;

    constructor() {
        rangeValue[Range.Child] = "Child";
        rangeValue[Range.Young] = "Young";
        rangeValue[Range.Middleaged] = "MiddleAged";
        rangeValue[Range.Old] = "Old";

    }

    function collectUsersAge(uint _age) public view returns(string memory){
        Range range;

         if(_age <= 12){
            range = Range.Child;
        }
         else if(_age > 12 && _age < 30){
            range = Range.Young;
        }
         else if(_age >= 30 && _age < 50){
            range = Range.Middleaged;
        }
         else{
            range = Range.Old;
        }

        return rangeValue[range];
    }
}