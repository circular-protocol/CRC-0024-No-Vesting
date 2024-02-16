/******************************************************************************************
*
*         Circular Protocol
*         Smart Contract Endpoints Test
*         January 2024
*
*******************************************************************************************/

/**
 * Here you can test the different contract's endpoints
 *
 * IMPORTANT: this piece of code will be executed only in debugging mode and it will 
 * emulate the transaction payload. Transaction payloads have usually only one call,
 * but the testing mode will allow you to add extra code creates the desired testing 
 * conditions. It is important to undertand that in debugging mode, no effect will be
 * produced on the wallet. In testing mode (transaction on the sandbox blockchain)
 * the wallets will be affected by the transactions.
/*

/**
 * Here you can assign manually the request details to recreate the desired conditions
 * msg.Blockchain='0x8a20baa40c45dc5055aeb26197c203e576ef389d9acb171bd62da11dc5ad72b2';
 * msg.ID='0x0000000000000000000000000000000000000000000'; 
 * msg.From='enter here your desired From Address';
 * msg.To='Text_Contract';
 * msg.Type='';
 * msg.Timestamp='';
 * msg.Signature='';
*/


/** 1 - Contract constructor testing ******************************************************/

//CRC_Contract._constructor();



/** 2 - Request total token supply ********************************************************/

CRC_Contract.__GetTotalSupply();



/** 3 - Request total token circulating supply ********************************************/

//CRC_Contract.__GetCirculatingSupply();




/** 4 - Request total token circulating supply ********************************************/

// CRC_Contract.__GetTokenName();



  
/** 5 - Request total token circulating supply ********************************************/
  
// CRC_Contract.__GetTokenSymbol();



  
/** 6 - Uncomment to test the GetBalance **************************************************/

//CRC_Contract.__GetBalance('enter here wallet address');




/** 7 - Drop testing **********************************************************************/

// CRC_Contract.ActiveSale(sale);




/** 8 - Drop testing **********************************************************************/

// CRC_Contract.Buy();



/** 9 - Drop testing **********************************************************************/

// Assign to msg.From the owner address in order to  simulate a call from the contract's owner
//msg.From = 'enter here owner address';

// drop to a desired address
//CRC_Contract.Drop('enter here wallet address', 1000);




/** 10 - Uncomment to test the transfer ****************************************************/

//CRC_Contract.Transfer('enter here wallet address', 1000);




/** 11 - uncomment to test the Approve *****************************************************/

//CRC_Contract.Approve('enter here wallet address', 100);




/** 12 - Uncomment to test the TransferFrom ************************************************/

//msg.From = 'enter here wallet address';
//CRC_Contract.TransferFrom('enter here wallet address', 
//                          'enter here wallet address', 100);
