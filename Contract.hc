/******************************************************************************************
*
*         Circular Protocol
*         CRC-0024 Smart Contract Template for standard fungible token 
*         January 2024
*
*******************************************************************************************/

/** 
 *
 *  TODO: Define CRC_Contract object 
 *
 *  Modify this template to build your own Token 
 *
 */

var CRC_Contract = {

/** 
 * TODO: Contract Class Initialization; Initialize here yout contract properties
 *
 */
  
    _TotalSupply : 100000000.00,   // Token Total Supply
        _Balance : 100000000.00,   // Initial Balance before sale
           _Name : "MyToken",      // Token Name. It must match the project name in the settings 
         _Symbol : "MTK",          // Asset Tiker.It must match the one in the settings 
          _owner : "Owner wallet address", // Asset Owner Address
         _OnSale : true,           // Token on sale flag
           _Rate : 100,            // $CIRX exchange rate
  
/** 
 * Contract Constructor. It will be executed only once, when the contract is deployed.
 *
 */
    _constructor: function() {
      
      // Create a new wallet instance
      var Owner = Object.create(CRC_Wallet); 
      
      // Loads the Owner's Wallet
      Owner.OpenWallet(this._owner);
      
      // Assignes the total Supply to the Owner
      Owner.Balance = this._TotalSupply;
      
      // Updates the Owner's wallet
      Owner.CloseWallet();
    },
  

/** 
 * Returns the total token supply.
 *
 */  
    __GetTotalSupply: function () {
      
        println('{ "TotalSupply" : ' + this._TotalSupply + ' }');
      
        return this._TotalSupply;
    },
  
    
/** 
 * Retrieves the total token circulating supply
 *
 */  
    __GetCirculatingSupply: function () {
      
        println('{ "CirculatingSupply" : ' + (this._TotalSupply - this._Balance) + ' }');
      
        return this._TotalSupply - this._Balance;
    },
  
  
  
/** 
 * Retrieves the token name 
 *
 */ 
__GetTokenName: function () {
    
    // priting the Token Name
    println('Token Name : ' + this._Name);
  
    // we return for internal uses
    return this._Name;
},    


  
/** 
 * Retrieves the token Symbol
 *
 */   
__GetTokenSymbol: function () {
    
    // priting the Token Symbol
    println('Token Symbol : ' + this._Symbol);
  
    // we return for internal uses
    return this._Symbol;
},   
  
  
  
/** 
 * Retrieves the token balance for a specified wallet address
 *
 * address : hexadecimal wallet address '0x...' 
 *
 */  
    __GetBalance: function (address) {
      
        // Creates a new wallet instance
        var wallet = Object.create(CRC_Wallet);
      
        // Opens the specified wallet
        if(wallet.OpenWallet(address)){
          
            // if the wallet is available prints out the balance
            println('{ "Balance" : "' + wallet.Balance + ' '+ this._Symbol + '" }');
            return wallet.Balance;
        }
        return -1;
    },


/** 
 *  Active/Deactive Token sale
 *
 *  sale : true = Sale ON, false = sale OFF
 *
 */   
    ActiveSale: function (sale) {
        // If the sender address is the contract owner
        if (msg.From == this._owner) {
          
          // sets the sale flag
          this._OnSale = sale;
          
          // prints message
          if(sale) println('Token Sale ON');
          else     println('Token Sale OFF');
          
          return true;
        }
      
        println('ActiveSale failed');
        return false;
    },
  

  
/** 
 *  Buys token through $CIRX
 *
 */   
    Buy: function () {
        // If are sent a positive amoutn of coins
        if (msg.Amount > 0) {
          
          // Calculates the right amount of tokens
          var amount = msg.Amount * this._Rate;
          
          // Creates a new wallet instance 
          var Owner = Object.create(CRC_Wallet); 
          
          // Loads the owner's  wallet
          Owner.OpenWallet(this._owner);
          
          // Create a new wallet instance 
          var buyer = Object.create(CRC_Wallet); 
          
          // Opens the buyer's wallet
          buyer.OpenWallet(msg.From);
            
          // If the wallet is available transfers the tokens to the recipient's Wallet
          buyer.Balance += Number(amount);

          // Removes the tokens out of the owner's wallet
          Owner.Balance -= Number(amount);

          // Removes the same amount  of tokens out of the contract's balance
          this._Balance -= Number(amount);
          
          // close the wallets
          Owner.CloseWallet();
          buyer.CloseWallet();

          // Print the message in JSON format
          println('{ "transferred" : ' + amount + ' ' + this.symbol + ', "To" : "' + msg.From + '"}');

          // now the CIRX will be subtracted by the sender wallet. 
          return true;
          
        }
      
        println('ActiveSale failed');
        return false;
    },
    
      
  
/** 
 *  Drops tokens from the Contract/Owner balance to a specified wallet
 *
 *  to : recipient's wallet address
 *
 *  amount : Amount of tokens being transferred
 *
 */  
    Drop: function (to, amount) {
      
        // If the sender address is the contract owner
        if (msg.From == this._owner && amount > 0) {
            
            // Creates a new wallet instance 
            var Owner = Object.create(CRC_Wallet); 
          
            // Loads the owner's  wallet
            Owner.OpenWallet(this._owner);
          
            // check if the owner has enough tokens for the drop
            if(Owner.Balance < amount)
            {
                  // Low balance
                  print("Low Balance\n");
                  return false;
            }
          
            // Create a new wallet instance 
            var To = Object.create(CRC_Wallet); 
          
            // Opens the recipient's wallet
            if(To.OpenWallet(to)){

                  // If the wallet is available transfers the tokens to the recipient's Wallet
                  To.Balance   += Number(amount);
                  
                  // Removes the tokens out of the owner's wallet
                  Owner.Balance-= Number(amount);
              
                  // Removes the same amount  of tokens out of the contract's balance
                  this._Balance -= Number(amount);

                  // Print the message in JSON format
                  println('{ "Dropped" : ' + amount + ', "To" : "' + To.Address + '"}');

                  // close the wallets
                  Owner.CloseWallet();
                  To.CloseWallet();
              
                  return true;
              
            } else {
              
                  // Invalid Recipient Address
                  print("Invalid Recipient\n");
              
                  return false;            
            }
        }
      
        // unauthorized Drop
        print("Invalid Drop\n");
      
        return false;
    },

  
/** 
 *  Transfers tokens to a specified wallet
 *
 *  to : recipient's wallet address
 *
 *  amount : Amount of tokens being transferred
 *
 */ 
    Transfer: function (to, amount) {
        
        // Createa a new wallet instance
        var From = Object.create(CRC_Wallet); 
      
        // Opens the Sender's wallet
        From.OpenWallet(msg.From);
      
        // If there are enough tokens and the amount is positive
        if (From.Balance >= amount && amount > 0) {
            
            // Create a new wallet instance 
            var To = Object.create(CRC_Wallet); 
          
            // Opens the recipient's wallet
            if(To.OpenWallet(to)){
              
                // Transfers the tokens
                From.Balance -= amount;
                To.Balance   += amount;
              
                //Prints out the message 
                println('{ "Transfered" : ' + amount + ', "To" : "' + To.Address + '"}');
              
                // Saves the wallets
                From.CloseWallet();
                To.CloseWallet();
              
                return true;
            } else {
              
                // Invalid Recipient Address
                print("Invalid Recipient\n");
              
                return false;    
            }
        }
      
        print("Transfer failed\n");
      
        return false;
    },

 
  
/** 
 *  Approves a new allowance
 *
 *  to : Allowance recipient's wallet address
 *
 *  amount : Amount of allowance authorization being created
 *
 */ 
    Approve: function (to, amount) {
      
        // Create a new wallet instance
        var To = Object.create(CRC_Wallet); 
      
        // Opens the recipient's wallet
        if(To.OpenWallet(to)){
          
            // Adds a new allowance from the sender's wallet (from) for a specified amount of tokens
            To.AddAllowance(msg.From, amount);
          
            //Print message on the Output
            print(msg.From + " approved " + To.Address + " to spend " + amount + " " + this._Symbol + "\n");
            
            // Saves the wallet
            To.CloseWallet();
          
            return true;
          
        } else {
          
            // Invalid Recipient Address
            print("Invalid Recipient\n");
          
            return false;    
          
        }
    },

  
/** 
 *  Transfers tokens from an allowance
 *
 *  owner : Allowance owner's wallet address (who is paying)
 *
 *  to : Allowance recipient's wallet address (who is receiving)
 *
 *  amount : Amount of tokens being transferred from owner to recipient
 *
 */   
    // transfer from the owner ************************************************************************ 
    TransferFrom: function (owner, to, amount) {
        
          // Create a new wallet instance
          var From = Object.create(CRC_Wallet); 
      
          // Open sender's wallet
          From.OpenWallet(msg.From);
      
          // if the allowance is found and is enough to satisfy the transaction
          if(From.SpendAllowance(owner, amount))
          { 
             // creates a new wallet instance
             var Owner  = Object.create(CRC_Wallet);
            
             // Opens the owner's wallet             
             if(Owner.OpenWallet(owner))
             {
                   // if the owner's balance is enough
                   if (Owner.Balance >= amount && amount > 0) {
                   
                        // Create a new wallet instance
                        var To = Object.create(CRC_Wallet); 
                     
                        // Opens the recipient's wallet
                        if(To.OpenWallet(to)){
                        
                           // Transfers the tokens
                           Owner.Balance -= amount;
                           To.Balance    += amount;
                          
                           // Prints the output message
                           println('{ "Transfered" : ' + amount + ', "To" : "' + To.Address + '"}');
                          
                           // Updates all the wallets 
                           From.CloseWallet();
                           Owner.CloseWallet();
                           To.CloseWallet();
                          
                           return true;
                         } 
                             
                         // Recipient address not opened
                         print("Transfer failed: Wrong recipient address\n");
                         return false;
                           
                   }
                   // Owner didn't have enough tokens 
                   print("Transfer failed: Balance low\n");
                   return false;
             }
             // Owner wallet was not available
             print("Transfer failed: Wrong Owne address\n");
             return false;
             
          }
          // Allowance not found or not enough to satisfy the transaction
          print("Transfer failed: Allowance not too low or not found\n");
          return false;
    }
};
