pragma solidity 0.5.12;

contract ERC20 {

    function transferFrom (address,address, uint256) external returns (bool);
    function balanceOf(address) public view returns (uint256);
    function allowance(address, address) external view returns (uint256);
    function transfer (address, uint256) external returns (bool);
    function burn (uint256) external returns (bool);
    function giveRewardsToStakers(address,uint256) external returns(bool);

}

contract Owned {

    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed from, address indexed _to);

    constructor(address _owner) public {
        owner = _owner;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

contract Pausable is Owned {
    event Pause();
    event Unpause();

    bool public paused = false;

    modifier whenNotPaused() {
      require(!paused);
      _;
    }

    modifier whenPaused() {
      require(paused);
      _;
    }

    function pause() onlyOwner whenNotPaused public {
      paused = true;
      emit Pause();
    }

    function unpause() onlyOwner whenPaused public {
      paused = false;
      emit Unpause();
    }
}


/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

}


contract SwissFarm is Pausable{


    using SafeMath for uint256;

    address public uniV2SwissEth;
    address public uniV2SwissDesh;

    address public SwissTokenAddress;

    uint256 public stakingRatioPairOne;
    uint256 public stakingRatioPairTwo;


    constructor(address swissEthAddress, address swissDeshAddress, address _swiss, address owner) public Owned(owner) {

      uniV2SwissEth = swissEthAddress;
      uniV2SwissDesh = swissDeshAddress;

      SwissTokenAddress = _swiss;
      stakingRatioPairOne = 125;
      stakingRatioPairTwo = 30;

    }

    function setAddress(address swissEthAddress, address swissDeshAddress) external onlyOwner returns(bool)
    {

      uniV2SwissEth = swissEthAddress;
      uniV2SwissDesh = swissDeshAddress;


            return true;
    }


    function setStakingRatio(uint256 value1, uint256 value2) external onlyOwner returns(bool)
    {

        stakingRatioPairOne = value1;
        stakingRatioPairTwo = value2;
        return true;
    }




    mapping (address => uint256) public swissEthStaked;
    mapping (address => uint256) public swissEthStakedTime;

    mapping (address => uint256) public swissDeshStaked;
    mapping (address => uint256) public swissDeshStakedTime;


   function stakedAllTokens (address userAddress) public view returns (uint256,uint256) {

       uint256 resswissEthStaked = swissEthStaked[userAddress];
       uint256 resswissDeshStaked = swissDeshStaked[userAddress];

       return (resswissEthStaked,resswissDeshStaked);

   }


   function StakingTime (address userAddress) public view returns (uint256,uint256) {

       uint256 resswissEthStakedTime = swissEthStakedTime[userAddress];
       uint256 resswissDeshStakedTime = swissDeshStakedTime[userAddress];

       return (resswissEthStakedTime, resswissDeshStakedTime);
   }


    function stakeSwissEthTokens(uint256 amount) public returns (bool) {

       require(ERC20(uniV2SwissEth).balanceOf(msg.sender) >= amount,'balance of a user is less then value');
       require(swissEthStaked[msg.sender] == 0, "Please claim  tokens first before new stake");
       uint256 checkAllowance = ERC20(uniV2SwissEth).allowance(msg.sender, address(this));
       swissEthStaked[msg.sender] = amount;
       swissEthStakedTime[msg.sender] = now;
       require (checkAllowance >= amount, 'allowance is wrong');
       require(ERC20(uniV2SwissEth).transferFrom(msg.sender,address(this),amount),'transfer From failed');

    }


    function claimableSwissETHSwissTokens (address user) public view returns (bool,uint256) {

        if (swissEthStaked[user] > 0){


            uint256 percent = swissEthStaked[user].div(100);
            return (true,percent.mul(stakingRatioPairOne));


        } else {return (false,0);}

    }

    function claimEthSwissSwissTokens() public returns (bool) {

        require(swissEthStaked[msg.sender]>0, "not staked any  tokens");
        require(now > swissEthStakedTime[msg.sender].add(604800), "4 hours not completed yet");
        require(ERC20(uniV2SwissEth).transfer(msg.sender,swissEthStaked[msg.sender]), " tokens Burned");

        uint256 percent = swissEthStaked[msg.sender].div(100);
        require(ERC20(SwissTokenAddress).giveRewardsToStakers(msg.sender, percent.mul(stakingRatioPairOne)));
        swissEthStaked[msg.sender] = 0;
        swissEthStakedTime[msg.sender] = 0;

    }

    function stakeSwissDeshTokens(uint256 amount) public returns (bool) {

       require(ERC20(uniV2SwissDesh).balanceOf(msg.sender) >= amount,'balance of a user is less then value');
       require(swissDeshStaked[msg.sender] == 0, "Please claim  tokens first before new stake");
       uint256 checkAllowance = ERC20(uniV2SwissDesh).allowance(msg.sender, address(this));
       swissDeshStaked[msg.sender] = amount;
       swissDeshStakedTime[msg.sender] = now;
       require (checkAllowance >= amount, 'allowance is wrong');
       require(ERC20(uniV2SwissDesh).transferFrom(msg.sender,address(this),amount),'transfer From failed');

    }


    function claimableSwissDeshSwissTokens (address user) public view returns (bool,uint256) {

        if (swissDeshStaked[user] > 0){


            uint256 percent = swissDeshStaked[user].div(100);
            return (true,percent.mul(stakingRatioPairTwo));


        } else {return (false,0);}

    }

    function claimSwissDeshSwissTokens() public returns (bool) {

        require(swissDeshStaked[msg.sender]>0, "not staked any  tokens");
        require(now > swissDeshStakedTime[msg.sender].add(604800), "4 hours not completed yet");
        require(ERC20(uniV2SwissDesh).transfer(msg.sender,swissDeshStaked[msg.sender]), " tokens Burned");

        uint256 percent = swissDeshStaked[msg.sender].div(100);
        require(ERC20(SwissTokenAddress).giveRewardsToStakers(msg.sender, percent.mul(stakingRatioPairTwo)));
        swissDeshStaked[msg.sender] = 0;
        swissDeshStakedTime[msg.sender] = 0;

    }}
