// SPDX-License-Identifier: MIT
pragma solidity = 0.7.3;

//SWISS Protocol Contract

/*
     _______.____    __    ____  __       _______.     _______.   
    /       |\   \  /  \  /   / |  |     /       |    /       |   
   |   (----` \   \/    \/   /  |  |    |   (----`   |   (----`   
    \   \      \            /   |  |     \   \        \   \       
.----)   |      \    /\    /    |  | .----)   |   .----)   |      
|_______/        \__/  \__/     |__| |_______/    |_______/       
  
                Oxygen#3000 => contact me
*/

library Address { // from ERC 223
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
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
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
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
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
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
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract IterableVote {
    
    address[] public votedAddress;
    uint[] public votedValue; // 1 = true ; 2 = false

    function addVote(uint _value) internal {
        if (votedValue.length >= getIndexByKey(msg.sender)) { // msg.sender did not vote
            votedAddress.push(msg.sender);
            votedValue.push(_value); 
        }
    }
    
    function endVote() internal {
        for (uint i; i < nbVote(); i++) {
            delete votedAddress;
            delete votedValue;
        }
    }

    function nbVote() public view returns (uint) {
        return uint(votedAddress.length);
    }
    
    function getByIndex(uint index) internal view returns (uint) {
        return votedValue[index];
    }
    
    function getKeyByIndex(uint index) internal view returns (address) {
        return votedAddress[index];
    }
    
    function getIndexByKey(address key) internal view returns (uint) {
        uint index;
        
        for (uint i; i < nbVote(); i++) {
            if (votedAddress[i] == key) {
                index = i;
            }
        }
        return index;
    }
    
}

contract SWISS is IterableVote {
    
    using SafeMath for uint;
    
    string private constant _name = "Swiss";
    string private constant _symbol = "SWISS";

    uint8 private constant _decimals = 18;
    uint private constant _totalSupply = 10000000000000000000000;
    
    uint private _lastRewardAdmin;
    uint private rewards_times = 0; // Reward step (0 - 4)
    
    // Fees
    uint public tx_fees_swiss = 50; //2%
    uint public tx_fees_decash = 100; //1%
    
    // Vote fees
    uint public startVotingTime;
    bool public inVoting;
    uint public inVotingFees;
    uint public inVotingType; // 1 = "SWISS" or 2 = "DeCash"
    uint public voteTime = 259600; //3 days

    event Approval(address indexed _owner, address indexed _spender, uint _value);
    event Transfer(address indexed from, address indexed to, uint value);
    event StartVote(uint indexed time, uint indexed fees, uint indexed typeFees); //fees : fees to vote
    event EndVote( uint indexed typeFees, bool indexed approved); //approved : true = new_fees accepted

    mapping(address => mapping (address => uint256)) allowed;
    mapping(address => uint) public balances;

    mapping (uint => address) public admin_wallets;
    address payable public fees_wallet_swiss; // Redirection wallet for liquidity for SWISS
    address payable public fees_wallet_decash; // Redirection wallet for liquidity for DeCash
    address payable public admin_locked_wallet; // Locked admin wallet (SWISS unlocked every week)
    address payable public base_liquidity_wallet; // Wallet for liquidity on Uniswap
    address payable public rewards_wallet; // Wallet for farming rewards

    constructor(uint adminRewardTriggerTime) {
        _lastRewardAdmin = block.timestamp + adminRewardTriggerTime; //Set the time of triggering (in seconde)
        
        fees_wallet_swiss = 0x991AC37b1cBD28131560A8e9ddb4D51F4dBcb8c9;
        fees_wallet_decash = 0xF033789a125545738D1ECCf0237083E62Ff21499;
        admin_locked_wallet = 0xc5B83Fe842919Ac329F67e7dB7704625149d9e4E;
        base_liquidity_wallet = 0x743d05c5A3354608037CA23761d2f9007D67029F;
        rewards_wallet = 0x32ea698a6276939AD5eE1fABfFEa26a2391a785D;

        //strategic, partenairs and founders' wallet :
        
        balances[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = 1000 * full_nb();
        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 500 * full_nb();
        balances[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = 600 * full_nb();
        
        admin_wallets[0] = 0x973878Fa3A9439DFB27F7DD1C107Fd6D581bB2f2; //Organisation wallet
        admin_wallets[1] = 0x0C6F8C0F523A9AA348fE99a7f740ED0aE171D7C2; //Founder
        admin_wallets[2] = 0x496079588149b6B019B36d1aCEf3b8FEE3C1613A; //Founder
        admin_wallets[3] = 0x7B45ec5d1501a2e2aca6c40E99f04729C7EdA633; //Dev 1
        admin_wallets[4] = 0x224F7803F9975c3a3bd64829db9908784fe52399; //Designer
        admin_wallets[5] = 0x5F459581D117be275dA8408942a9C92F22d98b39; //Partner
        admin_wallets[6] = 0x38cFfff72DcF64C3Fdbb66E23f7185Fb4769e01B; //Dev 2
        
        balances[admin_locked_wallet] = 2500 * full_nb();
        balances[base_liquidity_wallet] = 3500 * full_nb();
        balances[rewards_wallet] = 4000 * full_nb();
    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
    
    function lastRewardAdmin() public view returns (uint256) {
        return _lastRewardAdmin;
    }
    
    function full_nb() public pure returns (uint) {
        return 1000000000000000000; //18 zero for 18 decimals
    }
    
    // Add a vote
    function voteFees(uint vote) public returns (bool) {
        require(inVoting == true);
        require(vote == 1 || vote == 2);

        addVote(vote);
        return true;
    }
    
    // End Vote
    function endVoting() public returns (bool) {
        require(startVotingTime + voteTime < block.timestamp, "Vote is not over yet");
        require(inVoting == true, "No vote in progress");
        
        int voteResult;
        bool voteApproved;
        
        for (uint i; i < nbVote(); i++) {
            if (getByIndex(i) == 2) {
                voteResult -= int(balances[getKeyByIndex(i)]);
            }
            else if (getByIndex(i) == 1) {
                voteResult += int(balances[getKeyByIndex(i)]);
            }
        }
        
        if (voteResult > 0) {
            voteApproved = true;
            if (inVotingType == 1) {
                tx_fees_swiss = inVotingFees;
            }
            else if  (inVotingType == 2) {
                tx_fees_decash = inVotingFees;
            }
        }
        else { voteApproved = false; }
        
        endVote();
        inVotingType = 0;
        inVoting = false;
        
        emit EndVote(inVotingType, voteApproved);
        return true;
    }
    
    // Start a vote
    function startVoting(uint fees, uint typeFees) public returns (bool) {
        require(balances[msg.sender] >= (100 * full_nb()), "Not enought found"); // sender must be have more than 100 swiss (to protect from abusers)
        require(inVoting == false, "Vote already start");
        require(typeFees == 1 || typeFees == 2);
        
        //typeFees = 1 : SWISS // typeFees = 2 : DeCash
        
        inVotingType = typeFees;
        inVotingFees = fees;
        startVotingTime = block.timestamp;
        inVoting = true;
	    
	    emit StartVote(startVotingTime, fees, typeFees);
	    return true;
    }
  
    function approve(address _spender, uint256 _amount) public returns (bool success) {
        allowed[msg.sender][_spender] = _amount;

        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
    
    function allowance(address owner, address spender) public view returns (uint256) {
        return allowed[owner][spender];
    }
    
    function transfer(address _to, uint _value) public returns (bool success) {
        require(_to != msg.sender);
        require(balances[msg.sender] >= _value);
        require(_value > 0);
        require(msg.sender != admin_locked_wallet);

        uint sub_value_swiss = _value.div(tx_fees_swiss);
        uint sub_value_decash = _value.div(tx_fees_decash);
        _value = _value.sub(sub_value_swiss.add(sub_value_decash));

        if (Address.isContract(_to)) { // Take fees only on selling and buying
            
            //Redirection for the SWISS wallet : 
            balances[fees_wallet_swiss] = balances[fees_wallet_swiss].add(sub_value_swiss);
        
            //Redirection for the DECASH wallet :
            balances[fees_wallet_decash] = balances[fees_wallet_decash].add(sub_value_decash); 
        }

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value); 

        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        require(_to != _from);
        require(balances[_from] >= _value);
        require(_value >= 0);
        require(allowed[_from][msg.sender] >= _value);
        require(msg.sender != admin_locked_wallet);

        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

        uint sub_value_swiss = _value.div(tx_fees_swiss);
        uint sub_value_decash = _value.div(tx_fees_decash);
        _value = _value.sub(sub_value_swiss.add(sub_value_decash));

        if (Address.isContract(_to)) { // Take fees only on selling and buying
            
            //Redirection for the SWISS wallet : 
            balances[fees_wallet_swiss] = balances[fees_wallet_swiss].add(sub_value_swiss);
        
            //Redirection for the DECASH wallet :
            balances[fees_wallet_decash] = balances[fees_wallet_decash].add(sub_value_decash); 
        }
        
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value); 

        
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        approve(spender, allowed[msg.sender][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        approve(spender, allowed[msg.sender][spender].sub(subtractedValue));
        return true;
    }
    
    // Admins rewards unlocking :  

    function adminRewards() public {
        require(rewards_times <= 4);
        
        // J+1
        if (rewards_times == 0) { if (lastRewardAdmin() + 86400 <= block.timestamp) { 
            balances[admin_wallets[0]] = balances[admin_wallets[0]].add(200 * full_nb()); 
            balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(200 * full_nb());
            rewards_times = rewards_times.add(1); 
            _lastRewardAdmin = block.timestamp; } }
            
        else {
        
        if (lastRewardAdmin() + 604800 <= block.timestamp) { //604800 = 1 week
        
            // J+7
            if (rewards_times == 1) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(100 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(200 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(200 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(50 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(50 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(80 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(30 * full_nb());
                
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(710 * full_nb());}
                                        
            // J+14
            if (rewards_times == 2) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(50 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(200 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(200 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(50 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(50 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(80 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(30 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(660 * full_nb());}
                                        
            // J+21
            if (rewards_times == 3) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(30 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(170 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(170 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(30 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(30 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(50 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(25 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(505 * full_nb());}
                                        
            // J+28
            if (rewards_times == 4) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(30 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(150 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(150 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(20 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(20 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(40 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(15 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(425 * full_nb());}

            rewards_times = rewards_times.add(1); 
            _lastRewardAdmin = block.timestamp; 
            
            }
        
        } 
        
    }

}