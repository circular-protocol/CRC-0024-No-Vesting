/******************************************************************************************
*
*         Circular Protocol
*         Smart Contract Output Definition
*         January 2024
*
*******************************************************************************************/




/** Printing output for debugging *********************************************************/

if(msg.Type == "C_TYPE_HC_TEST")
{
  
    /** TODO: Enter here anything that needs to be printed to debug your code */
  
    println('<br><span style="color:green;">MESSAGE INFO-------------------------------</span><br>');
    println('Blockchain: <span style="color:red;">' + msg.Blockchain +'</span>');
    println('ID:0x' + msg.ID);
    println('From:0x' + msg.From);
    println('To:0x' + msg.To);
    println('Type:<span style="color:orange;">' + msg.Type +'</span>');
    println('Timestamp:0x' + msg.Timestamp);
    println('Signature:' + msg.Signature);
}


/* Extracts and stores the smart contract's execution state *******************************/
_Contract_State = _Save_Contract_State(CRC_Contract);
