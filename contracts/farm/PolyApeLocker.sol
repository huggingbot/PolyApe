// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./libs/IERC20.sol";
import "./libs/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/access/Ownable.sol";

/**
 * @dev PolyApeLocker contract locks the liquidity (LP tokens) which are added by the automatic liquidity acquisition
 * function in PolyApeToken.
 *
 * The owner of PolyApeLocker will be transferred to the timelock once the contract deployed.
 *
 * Q: Why don't we just burn the liquidity or lock the liquidity on other platforms?
 * A: If there is an upgrade of PolyApeSwap AMM, we can migrate the liquidity to our new version exchange.
 *
 * Website: https://polyapeswap.com
 * Twitter: https://twitter.com/PolyApeSwap
 */
contract PolyApeLocker is Ownable {
    using SafeERC20 for IERC20;

    event Unlocked(
        address indexed token,
        address indexed recipient,
        uint256 amount
    );

    function unlock(IERC20 _token, address _recipient) public onlyOwner {
        require(
            _recipient != address(0),
            "PolyApeLocker::unlock: ZERO address."
        );

        uint256 amount = _token.balanceOf(address(this));
        _token.safeTransfer(_recipient, amount);
        emit Unlocked(address(_token), _recipient, amount);
    }
}
