import org.chocosolver.solver.Model;
import org.chocosolver.solver.variables.IntVar;

public class CSP {

	public static void prob1(){
		Model model = new Model("my model");
		
		IntVar x = model.intVar("x", 0, 5); 
		IntVar y = model.intVar("y", new int[]{2, 3, 8});
		
		//Constraints
		model.arithm(x, "+", y, "<=", 5).post();
		model.times(x,y,6).post(); //x*y=4
		
		model.getSolver().solve();
		
		System.out.println(x);
		System.out.println(y);
	}
	
	
	public static void Olympic(){
		Model model = new Model("olympic");
		
		int n = 10;
		IntVar[] x = model.intVarArray("x",n, 1, 10, true);
		
		
		//Constraints
		model.arithm(x[0], "=", 3).post();
		model.allDifferent(x).post();
		
		
		model.distance(x[1], x[2], "=", x[0]).post();
		
		model.distance(x[3], x[4], "=", x[2]).post();
		model.distance(x[4], x[5], "=", x[1]).post();
		
		model.distance(x[6], x[7], "=", x[3] ).post();
		model.distance(x[7], x[8], "=", x[4]).post();
		model.distance(x[8], x[9], "=", x[5]).post();
		
		
		
		model.getSolver().showStatistics();
		
		model.getSolver().solve();	
		for(int i = 0; i<n; i++){
			System.out.println(x[i]);			
		}
		
	}
	
	
	
	
	public static void knapsack(){
		
		//Data
		int[] w = new int[]{7,8,4,2,3,5,4};
		int[] p = new int[]{5,30,1,8,3,6,5};
		int   W = 15;
		int   n = 7;
		
		
		//creating model
		Model model = new Model();
		IntVar[] x  = model.intVarArray("x",n,0,1);
		IntVar   z  = model.intVar("z", 0, 100);
		
		
		//constraint and objective
		model.scalar(x, w, "<=", W).post();
		model.scalar(x, p, "=", z).post();
		
		model.setObjective(Model.MAXIMIZE, z);
		
		
		//Solving
		model.getSolver().solve();
		System.out.println(z);
		
		for(int i = 0; i<n; i++){
			System.out.println(x[i]);			
		}
		
	}
	
	
	
	public static void main(String[] args) {
		//prob1();
		//knapsack();
		Olympic();
	}

}
