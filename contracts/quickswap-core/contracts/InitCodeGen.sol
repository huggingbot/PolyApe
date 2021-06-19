pragma solidity =0.5.16;

import './UniswapV2Pair.sol';

contract InitCodeGen {
    event InitCode(bytes32 initCode);
    
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(UniswapV2Pair).creationCode));
    
    constructor() public {
        emit InitCode(INIT_CODE_PAIR_HASH);
    }
}

