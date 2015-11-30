/*********************************************
 * OPL 12.4 Model
 * Author: rboudjeltia
 * Creation Date: 30 nov. 2015 at 10:19:17
 *********************************************/

 using CP;
 
 
 int NbFlight  = ...;
 int NbStew    = ...;
 int NbHost    = ...;
 
 int NbMem     = NbStew + NbHost;
 
 int MemFlight = ...;
 int MemHost   = ...;
 int MemStew   = ...;
 
{string} Stewards  = ...;
{string} Hostesses = ...;

string Lang[t in 1..16] = ...;

dvar int S[i in 1..NbStew][j in 1..NbFlight];
dvar int H[i in 1..NbHost][j in 1..NbFlight];

execute {
  cp.param.FailLimit = 10000;
}


//minimize the number of members used for all flight
minimize sum(j in 1..NbFlight)( sum(i in 1..NbHost) H[i][j] + sum(i in 1..NbFlight) S[i][j]); 



//if S[i][j] = 1 then S[i][j+1] = S[i][j+2] = S[i][j+2]
//if S[i][j] = 1 then H[i][j+1] = H[i][j+2] = H[i][j+2]

subject to{
  
  
  
  
}  