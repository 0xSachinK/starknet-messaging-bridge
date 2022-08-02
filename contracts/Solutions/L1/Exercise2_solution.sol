pragma solidity ^0.8.0;

import "../../L1/interfaces/IStarknetCore.sol";


contract Exercise2_Solution {

    IStarknetCore starknetCore = IStarknetCore(0xde29d060D45901Fb19ED6C6e959EB22d8626708e);

    uint256 public evaluatorContractAddress = 2526149038677515265213650328426051013974292914551952046681512871525993794969;

    // >>> from starkware.starknet.compiler.compile import get_selector_from_name
    // >>> print(get_selector_from_name('ex2'))
    // 897827374043036985111827446442422621836496526085876968148369565281492581228
    uint256 public ex2_selector = 897827374043036985111827446442422621836496526085876968148369565281492581228;
    uint256 public l2_user = 2806752771329879808604343318731674196484924909091370981982786762941452330983;
    
    function createNftOnL2() public {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2_user;
        starknetCore.sendMessageToL2(evaluatorContractAddress, ex2_selector, payload);
    }
}