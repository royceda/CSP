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

string Lang[t in NbMem] = ...;

