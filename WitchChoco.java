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
	
	
	
	public static void binpacking(){
		System.out.println("Bin packing");
		int n = 5; //item
		int m = 4; //bin
		
		int[] c = {10,15,12,11}; //capacities
		int[] w = {5,8,1,6,4}; //sizes
		
		Model model = new Model("Bin packing");
		
		IntVar[][] x = model.intVarMatrix("x",n,m, 0, 1);
		IntVar[][] xt = model.intVarMatrix("x",m,n, 0, 1); //transpose
		IntVar[]   y = model.intVarArray("y", m, 0,1);
		

		// transpose: m x n cts
		for(int i = 0; i<n; i++){
			for(int j = 0; j<m; j++){
				model.arithm(x[i][j], "=", xt[j][i]).post();			
			}
		}
		
		
		//KP constraints: m cts
		for(int j = 0; j<m; j++){
			IntVar W = model.intScaleView(y[j], c[j]); 
			model.scalar(xt[j], w, "<=", W).post();
		}
		
		
		//unique constrainst: n cts
		for(int i = 0; i<n; i++){
			model.sum(x[i], "=", 1).post();
		}
		
		
		IntVar   z  = model.intVar("z", 0, m);
		model.sum(y, "=", z).post();
		model.setObjective(Model.MINIMIZE, z);
		
		
		
		model.getSolver().showStatistics();
		
		
		while(model.getSolver().solve()){	
			System.out.println(z);
			for(int j = 0; j<m; j++){
				System.out.println(y[j]);
				for(int i = 0; i<n; i++)
					System.out.println(x[i][j]);			
			}
		}
		
		/*ParallelPortfolio portfolio = new ParallelPortfolio();
		int nbModels = 1;
		for(int s=0;s<nbModels;s++){
			portfolio.addModel(model);
		}
		portfolio.solve();*/

	}
	
	
	
	
	public static void main(String[] args) {
		//prob1();
		//knapsack();
		Olympic();
		binpacking();
	}

}
