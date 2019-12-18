pragma solidity 0.5.7;
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";
pragma experimental ABIEncoderV2;

contract DAGSwap is Ownable {
    mapping (address => string) public mappedAddresses;
    address[] internal keyList;

    function mapAddress(string memory _dagAddress)
        public
    {
        address ethAddress = msg.sender;
        require(bytes(mappedAddresses[ethAddress]).length == 0);
        if (!existsInKeyList(ethAddress)){
            keyList.push(ethAddress);
        }
        mappedAddresses[ethAddress] = _dagAddress;
    }

    function existsInKeyList(address _ethAddress)
        private view returns (bool)
    {
        for (uint i = 0; i < keyList.length; i++) {
        if (keyList[i] == _ethAddress){
            return true;
            }
        }
        return false;
    }


    function removeMappedAddress(address _ethAddress)
        public
    {
        require(bytes(mappedAddresses[_ethAddress]).length != 0);
        require(msg.sender == _ethAddress);
        delete mappedAddresses[_ethAddress];
    }

    function getMappedAddresses()
        public view returns (string[] memory)
    {
    string[] memory ret = new string[](keyList.length);
    for (uint i = 0; i < keyList.length; i++) {
        ret[i] = mappedAddresses[keyList[i]];
    }
    return ret;
    }

    function getKeyList()
        public view returns (address[] memory)
    {
    address[] memory staticKeyList = new address[](keyList.length);
    for (uint i = 0; i < keyList.length; i++) {
        staticKeyList[i] = keyList[i];
    }
    return staticKeyList;
    }
}