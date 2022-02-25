contract Functions{

struct village{
    string head;
    uint houses;
    mapping(string=>mapping(uint=>address)) houseToWallet;
}


struct Cities{
uint districts;
string[] districtNames;
uint[] zipCodes;
string governor;
mapping(address=>uint) balances;
mapping(uint=>village) villages;
}

struct CitiesWithoutbalances{
uint districts;
string[] districtNames;
uint[] zipCodes;
string governor;
}




mapping(string=>Cities) allCityNames;

function addCity(uint _d,string[] memory _dn,uint[] memory _zc,string calldata _g,string calldata cityName) external{
Cities storage c=allCityNames[cityName];
c.districts=_d;
c.districtNames=_dn;
c.zipCodes=_zc;
c.governor=_g;

}

// function seeCities(string[] calldata _cn) external view returns(Cities[] memory ccc){
//  ccc=new Cities[](_cn.length);
// for(uint i=0;i<_cn.length;i++){
//     ccc[i]=allCityNames[_cn[i]];
// }
// }


function checkCity(string calldata cityName) external view returns(CitiesWithoutbalances memory c){
  Cities storage ci=allCityNames[cityName];
c.districts=ci.districts;
c.districtNames=ci.districtNames;
c.zipCodes=ci.zipCodes;
c.governor=ci.governor;
}

function changeGovernor(string calldata _newGovernor,string calldata _city) external {
    allCityNames[_city].governor=_newGovernor;
}


// function getWallet(string memory house,uint no,string calldata cityName) external view returns(address wallet){
// wallet=allCityNames[cityName].v.houseToWallet[house][no];
// }

function editVillage(string calldata _cn,string calldata vh,uint nHouses) external{
   Cities storage c=allCityNames[_cn]; 
village storage v= c.villages[1];


}
}