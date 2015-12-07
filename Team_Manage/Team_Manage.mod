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
 
 //string Lang[t in 1..16] = ...;

int Lang1[1..3][1..NbStew] = ...;
int Lang2[1..3][1..NbHost] = ...;

/**********************/
/* Decision variables */
/**********************/

dvar int S[i in 1..NbStew][j in 1..NbFlight] in 0..1; //Steward for a flight  0 or 1
dvar int H[i in 1..NbHost][j in 1..NbFlight] in 0..1; //Hostess for a flight  0 or 1

/**********************/
/* Preprocessing      */
/**********************/

execute {
  cp.param.FailLimit = 10000;
}

/**********************/
/* Objective function */
/**********************/

//minimize the number of members used for all flight
maximize sum(j in 1..NbFlight)( sum(i in 1..NbHost)(H[i][j]) + sum(i in 1..NbFlight)(S[i][j])); 

/***************/
/* Constraints */
/***************/

subject to{
  
  //constraint 1
  forall(j in 1..NbFlight){
   limitct:  sum(i in 1..NbStew)(S[i][j]) + sum(i in 1..NbHost)(H[i][j]) <=  MemFlight[j];
   }  
  
  
  //constraint 2
  forall(j in 1..NbFlight){
   Stewardct: sum(i in  1..NbStew)S[i][j] >= MemStew[j]; 
   }     
  
   
  //constraint 3
  forall(j in 1..NbFlight){
   Hostct: sum(i in 1..NbHost)H[i][j] >= MemHost[j];
  } 
  
  //constraint 4
  //language
  forall(j in 1..3){
    ct: sum(i in 1..NbStew)(S[j][i]+Lang1[j][i]) + sum(i in 1..NbHost)(H[j][i] + Lang2[j][i]) >= 1;
    
  }      
  
  
  //constraint 5
  forall(j in 1..NbFlight-2){
    forall(i in 1..NbStew){
       Dispoct1: 
       S[i][j] + S[i][j+1] + S[i][j+2] <= 1;
     }       
     forall(i in 1..NbHost){
       Dispoct2: 
       H[i][j] + H[i][j+1] + H[i][j+2] <= 1;
     }       
   }         
  
}  