// SPDX-License-Identifier: MIT
pragma solidity = 0.7.4;

//SWISS Protocol Contract

/*
     _______.____    __    ____  __       _______.     _______.   
    /       |\   \  /  \  /   / |  |     /       |    /       |   
   |   (----` \   \/    \/   /  |  |    |   (----`   |   (----`   
    \   \      \            /   |  |     \   \        \   \       
.----)   |      \    /\    /    |  | .----)   |   .----)   |      
|_______/        \__/  \__/     |__| |_______/    |_______/       
  
                Oxygen#3333 => contact me
*/


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
    
    function add(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a + b;
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
    
    function sub(int256 a, int256 b) internal pure returns (int256) {
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

    function sub(int256 a, int256 b, string memory errorMessage) internal pure returns (int256) {
        require(b <= a, errorMessage);
        int256 c = a - b;

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
    
    function mul(int256 a, int256 b) internal pure returns (int256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        int256 c = a * b;
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
    
    function div(int256 a, int256 b) internal pure returns (int256) {
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
    
    function div(int256 a, int256 b, string memory errorMessage) internal pure returns (int256) {
        require(b > 0, errorMessage);
        int256 c = a / b;
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

    function mod(int256 a, int256 b) internal pure returns (int256) {
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
    
    function mod(int256 a, int256 b, string memory errorMessage) internal pure returns (int256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract SWISS {
    
    using SafeMath for uint;
    using SafeMath for int;
    
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
    struct voteInfo {
        bool locked; // If the wallet can transfer / transferfrom
        uint lastVoteIndex; // Last vote of the wallet
        uint content; // Actual vote (1 or 2 <=> yes or no) of the wallet
    }

    mapping(address => voteInfo) voted;

    uint public numberVote; // Number of votes casted
    int public voteResult = 0; // The vote is accepted if result > 0
    
    uint public startVotingTime;
    bool public inVoting;
    uint public inVotingFees;
    uint public inVotingType; // 1 = "SWISS" or 2 = "DeCash"
    uint public voteTime = 259200; //3 days

    event Approval(address indexed _owner, address indexed _spender, uint _value);
    event Transfer(address indexed from, address indexed to, uint value);
    event StartVote(uint indexed time, uint indexed fees, uint indexed typeFees); //fees : fees to vote
    event EndVote( uint indexed typeFees, bool indexed approved); //approved : true = new_fees accepted

    mapping(address => mapping (address => uint256)) allowed;
    mapping(address => uint) public balances;

    mapping (uint => address) public admin_wallets;
    address public UNISWAP_ROUTER_ADDRESS;
    address payable public fees_wallet_swiss; // Redirection wallet for liquidity for SWISS
    address payable public fees_wallet_decash; // Redirection wallet for liquidity for DeCash
    address payable public admin_locked_wallet; // Locked admin wallet (SWISS unlocked every week)
    address payable public base_liquidity_wallet; // Wallet for liquidity on Uniswap
    address payable public rewards_wallet; // Wallet for farming rewards

    constructor(uint adminRewardTriggerTime) {
        _lastRewardAdmin = block.timestamp + adminRewardTriggerTime; //Set the time of triggering (in seconde)
        
        UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        
        fees_wallet_swiss = 0x991AC37b1cBD28131560A8e9ddb4D51F4dBcb8c9;
        fees_wallet_decash = 0xF033789a125545738D1ECCf0237083E62Ff21499;
        admin_locked_wallet = 0xc5B83Fe842919Ac329F67e7dB7704625149d9e4E;
        base_liquidity_wallet = 0x743d05c5A3354608037CA23761d2f9007D67029F;
        rewards_wallet = 0x32ea698a6276939AD5eE1fABfFEa26a2391a785D;

        //strategic, partenairs and founders' wallet :
        
        admin_wallets[0] = 0x973878Fa3A9439DFB27F7DD1C107Fd6D581bB2f2; // Organisation wallet 
        admin_wallets[1] = 0x0C6F8C0F523A9AA348fE99a7f740ED0aE171D7C2; // Team number 1
        admin_wallets[2] = 0x496079588149b6B019B36d1aCEf3b8FEE3C1613A; // Team number 2
        admin_wallets[3] = 0x7B45ec5d1501a2e2aca6c40E99f04729C7EdA633; // Team number 3
        admin_wallets[4] = 0x224F7803F9975c3a3bd64829db9908784fe52399; // Team number 4
        admin_wallets[5] = 0x5F459581D117be275dA8408942a9C92F22d98b39; // Team number 5
        admin_wallets[6] = 0x38cFfff72DcF64C3Fdbb66E23f7185Fb4769e01B; // Team number 6
        admin_wallets[7] = 0xfe5408a38F0Afba44Fd5Ed77E34D0943E354264a; // Team number 7
        admin_wallets[8] = 0xc17F69891407f3FD666E27c635F5d970a77b4A9F; // Team number 8
        
        balances[admin_locked_wallet] = 2500 * full_nb();
        balances[base_liquidity_wallet] = 3500 * full_nb();
        balances[rewards_wallet] = 4000 * full_nb();
    }
    
    /**
     * 
     * TOKEN BASEMENTS FUNCTIONS :
     * 
     */

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
    
    /**
     * 
     * GOVERNANCE SYSTEM's FUNCTIONS :
     * 
     */
    
    /**
     * Vote for changing buy and sell fees
     * 
     *  Requirements :
     *      -Vote in progress
     *      -The voter has not yet voted
     *      -vote is 1 or 2 :
     * 
     *      -vote : 1 is true (to accept proposal) and 2 is false (to reject proposal)
     */
     
    function voteForFees(uint vote) public returns (bool) { 
        require(inVoting == true, "No vote in progress");
        require(voted[msg.sender].lastVoteIndex != numberVote, "Already voted");
        require(vote == 1 || vote == 2); // 1 = yes, 2 = no
        
        voted[msg.sender].content = vote;
        voted[msg.sender].locked = true;
        voted[msg.sender].lastVoteIndex = numberVote;
        
        if (vote == 1) {
            voteResult = voteResult.add(int(balances[msg.sender]));
        }
        else if (vote == 2) {
            voteResult = voteResult.sub(int(balances[msg.sender]));
        }
        
        return true;
    }
        
    /**
     * Remove Vote for changing buy and sell fees
     * 
     * The vote is remove and the tokens are unlock
     * 
     *  Requirements :
     *      -Vote in progress
     *      -The voter has already voted
     */
    
    function unvoteForFees() public returns (bool) {
        require(inVoting == true, "No vote in progress");
        require(voted[msg.sender].lastVoteIndex == numberVote, "No vote registered");
        
        if (voted[msg.sender].content == 1) {
            voteResult = voteResult.sub(int(balances[msg.sender]));
        }
        else if (voted[msg.sender].content == 2) {
            voteResult = voteResult.add(int(balances[msg.sender]));
        }
        
        voted[msg.sender].content = 0;
        voted[msg.sender].locked = false;
        voted[msg.sender].lastVoteIndex = 0;
        
        return true;
    }
    
    /**
     * End a vote for changing buy and sell fees
     * 
     * The proposal is accepted if voteResult is more than 0
     * 
     *  Requirements :
     *      -Vote in progress
     *      -Voting time is over
     */
     
    function endVoting() public returns (bool) {
        require(inVoting == true, "No vote in progress");
        require(startVotingTime.add(voteTime) < block.timestamp, "Voting time is not over yet");
        
        if (voteResult > 0) {
            if (inVotingType == 1) {
                tx_fees_swiss = inVotingFees;
            }
            else {
                tx_fees_decash = inVotingFees;
            }
        }
        
        inVotingType = 0;
        inVotingFees = 0;
        inVoting = false;
        voteResult = 0;
        
        return true;
    }
    
    /**
     * Start a vote for changing buy and sell fees
     * 
     *  Requirements :
     *      -No vote in progress
     *      -The proponent have more than 100 SWISS
     *      -VotingType is 1 or 2 :
     * 
     *      -VotingType : 1 is for SWISS Fees and 2 is for DeCash Fees
     *      -newFees : amount of the Fees if the proposal is accepted
     */
     
    function startVoting(uint VotingType, uint newFees) public returns (bool) {
        require(inVoting == false, "Vote already in progress");
        require(balances[msg.sender] > uint(100).mul(full_nb()), "You need to have more than 100 SWISS to start a vote");
        require(VotingType == 1 || VotingType == 2); // 1 = Vote for SWISS; 2 = Vote for DeCash
        
        startVotingTime = block.timestamp;
        inVotingType = VotingType;
        inVotingFees = newFees;
        inVoting = true;
        numberVote++;
        
        return true;
    }
    
    // Return Voting type and the new fees being voted on (0, 0 for no Voting)
    function getCurrenVote() public view returns (uint, uint) {
        return (inVotingType, inVotingFees);
    }
    
    /**
     * 
     * ERC BASEMENTS FUNCTIONS :
     * 
     */
  
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
        require(balances[msg.sender] >= _value, "Don't have enought SWISS");
        require(_value > 0, "Need to send more than O Swiss");
        require(msg.sender != admin_locked_wallet);
        require(voted[msg.sender].locked == false || (voted[msg.sender].locked == true && voted[msg.sender].lastVoteIndex != numberVote), "Tokens are locked by the vote");

        balances[msg.sender] = balances[msg.sender].sub(_value);
        if (msg.sender == UNISWAP_ROUTER_ADDRESS || _to == UNISWAP_ROUTER_ADDRESS) { // Take fees only on selling and buying
        
            uint sub_value_swiss = _value.div(tx_fees_swiss);
            uint sub_value_decash = _value.div(tx_fees_decash);
            _value = _value.sub(sub_value_swiss.add(sub_value_decash));
            
            //Redirection for the SWISS wallet : 
            balances[fees_wallet_swiss] = balances[fees_wallet_swiss].add(sub_value_swiss);
            emit Transfer(msg.sender, fees_wallet_swiss, sub_value_swiss);

            //Redirection for the DECASH wallet :
            balances[fees_wallet_decash] = balances[fees_wallet_decash].add(sub_value_decash); 
            emit Transfer(msg.sender, fees_wallet_decash, sub_value_decash);
        }

        
        balances[_to] = balances[_to].add(_value); 

        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        require(_to != _from);
        require(balances[_from] >= _value, "Don't have enough SWISS");
        require(_value >= 0, "Need to send more than O Swiss");
        require(allowed[_from][msg.sender] >= _value, "Don't have enough allowance");
        require(_from != admin_locked_wallet);
        require(voted[_from].locked == false, "Tokens are locked by the vote");

        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        balances[_from] = balances[_from].sub(_value);

        if (_from == UNISWAP_ROUTER_ADDRESS || _to == UNISWAP_ROUTER_ADDRESS) { // Take fees only on selling and buying
        
            uint sub_value_swiss = _value.div(tx_fees_swiss);
            uint sub_value_decash = _value.div(tx_fees_decash);
            _value = _value.sub(sub_value_swiss.add(sub_value_decash));
            
            //Redirection for the SWISS wallet : 
            balances[fees_wallet_swiss] = balances[fees_wallet_swiss].add(sub_value_swiss);
            emit Transfer(_from, fees_wallet_swiss, sub_value_swiss);
        
            //Redirection for the DECASH wallet :
            balances[fees_wallet_decash] = balances[fees_wallet_decash].add(sub_value_decash); 
            emit Transfer(_from, fees_wallet_decash, sub_value_decash);
        }
        
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
    
    /**
     * 
     * ADMIN REWARD UNLOCKING FUNCTION :
     * 
     */

    function adminRewards() public {
        require(rewards_times <= 4);
        
        // reward D+1 after lunching :
        if (rewards_times == 0) { if (lastRewardAdmin() + 86400 <= block.timestamp) { 
            
            balances[admin_wallets[0]] = balances[admin_wallets[0]].add(200 * full_nb()); 
            
            balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(200 * full_nb());
            
            rewards_times = rewards_times.add(1); 
            _lastRewardAdmin = block.timestamp; } }
            
        else {
        
        if (lastRewardAdmin() + 604800 <= block.timestamp) { //604800 = 1 week
        
            // reward D+7 after lunching :
            if (rewards_times == 1) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(70 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(180 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(180 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(30 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(30 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(25 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(3 * full_nb());
                                        balances[admin_wallets[7]] = balances[admin_wallets[7]].add(65 * full_nb());
                                        balances[admin_wallets[8]] = balances[admin_wallets[8]].add(65 * full_nb());
                
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(648 * full_nb());}
                                        
            // reward D+14 after lunching :
            if (rewards_times == 2) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(50 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(180 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(180 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(30 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(30 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(25 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(3 * full_nb());
                                        balances[admin_wallets[7]] = balances[admin_wallets[7]].add(65 * full_nb());
                                        balances[admin_wallets[8]] = balances[admin_wallets[8]].add(65 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(628 * full_nb());}
                                        
            // reward D+21 after lunching :
            if (rewards_times == 3) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(50 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(160 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(160 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(25 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(25 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(20 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(2 * full_nb());
                                        balances[admin_wallets[7]] = balances[admin_wallets[7]].add(55 * full_nb());
                                        balances[admin_wallets[8]] = balances[admin_wallets[8]].add(55 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(552 * full_nb());}
                                        
            // reward D+28 after lunching :
            if (rewards_times == 4) {   balances[admin_wallets[0]] = balances[admin_wallets[0]].add(40 * full_nb());
                                        balances[admin_wallets[1]] = balances[admin_wallets[1]].add(150 * full_nb());
                                        balances[admin_wallets[2]] = balances[admin_wallets[2]].add(150 * full_nb());
                                        balances[admin_wallets[3]] = balances[admin_wallets[3]].add(20 * full_nb()); 
                                        balances[admin_wallets[4]] = balances[admin_wallets[4]].add(20 * full_nb());
                                        balances[admin_wallets[5]] = balances[admin_wallets[5]].add(10 * full_nb());
                                        balances[admin_wallets[6]] = balances[admin_wallets[6]].add(2 * full_nb());
                                        balances[admin_wallets[7]] = balances[admin_wallets[7]].add(40 * full_nb());
                                        balances[admin_wallets[8]] = balances[admin_wallets[8]].add(40 * full_nb());
                                        
                                        balances[admin_locked_wallet] = balances[admin_locked_wallet].sub(472 * full_nb());}

            rewards_times = rewards_times.add(1); 
            _lastRewardAdmin = block.timestamp; 
            
            }
        
        } 
        
    }

}
