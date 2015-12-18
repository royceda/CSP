/*********************************************
 * OPL 12.4 Model
 * Author: rboudjeltia
 * Creation Date: 30 nov. 2015 at 10:19:17
 *********************************************/

 using CP;
 
 
/********************/
/* Data declaration */
/********************/
 
 int NbFlight  = ...;
 int NbStew    = ...;
 int NbHost    = ...;
 
 //int NbMem     = NbStew + NbHost;
 
 int MemFlight[1..NbFlight] = ...;
 int MemHost[1..NbFlight]   = ...;
 int MemStew[1..NbFlight]   = ...;
 
 {string} Stewards  = ...;
 {string} Hostesses = ...;
 {string} Flight = ...;
 
 //string Lang[t in 1..16] = ...;

{string} Lang = ...;
{string} LangS [t in Lang] = ...;
{string} LangH [t in Lang] = ...;



/**********************/
/* Decision variables */
/**********************/

dvar int S[i in Stewards][j in 1..NbFlight] in 0..1; //Steward for a flight  0 or 1
dvar int H[i in Hostesses][j in 1..NbFlight] in 0..1; //Hostess for a flight  0 or 1

/**********************/
/* Preprocessing      */
/**********************/

execute {
  cp.param.FailLimit = 10000;
}

/**********************/
/* Objective function */
/**********************/

//maximize the number of members used for all flight
maximize sum(j in 1..NbFlight)( sum(i in Hostesses)(H[i][j]) + sum(i in Stewards)(S[i][j])); 

/***************/
/* Constraints */
/***************/

subject to{
  
  //constraint 1
  forall(j in 1..NbFlight){
   limitct:  sum(i in Stewards)(S[i][j]) + sum(i in Hostesses)(H[i][j]) ==  MemFlight[j];
   }  
  
  
  //constraint 2
  forall(j in 1..NbFlight){
   Stewardct: sum(i in  Stewards)S[i][j] >= MemStew[j]; 
   }     
  
   
  //constraint 3
  forall(j in 1..NbFlight){
   Hostct: sum(i in Hostesses)H[i][j] >= MemHost[j];
  } 
  
  //constraint 4
  //language
  /*forall(k in 1..3){
    forall(j in 1..NbFlight)
       langct: sum(i in Stewards)(S[i][j]*Lang1[k][i]) + sum(i in Hostesses)(H[i][j] * Lang2[k][i]) >= 1;
    
  } */
  
  
    forall(i in 1..NbFlight) {
   	 		forall( l in Lang){	   	 	
   	 			//sum(s in LangS[l])S[s][i] + sum(h in LangH[l])H[h][i] >= 1;
   	 			sum(s in LangS[l])S[s][i]  >= 1; 			 			
   	 			
     	 }
    }         	 			
    			 			      			 
     			 
         
     
  
  
  
  
  
  
  
  
  
  
  //constraint 5
  forall(j in 1..NbFlight-2){
    forall(i in Stewards){
       Dispoct1: 
       S[i][j] + S[i][j+1] + S[i][j+2] <= 1;
     }       
     forall(i in Hostesses){
       Dispoct2: 
       H[i][j] + H[i][j+1] + H[i][j+2] <= 1;
     }       
   }         
  
}  