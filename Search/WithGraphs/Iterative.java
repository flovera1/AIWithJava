import java.util.InputMismatchException;
import java.util.*;

public class Iterative{
	public static void main(String[] args){
		int numberOfNodes, destination;
		Scanner scanner = null;
		try{
			System.out.println("Enter the number of nodes in the graph");
			scanner                       = new Scanner(System.in);
			numberOfNodes                 = scanner.nextInt();
			int adjacencyMatrix[][]       = new int[numberOfNodes][numberOfNodes];
			System.out.println("Enter the adjacency matrix ");
			for(int i = 0; i < numberOfNodes; i++){
				for(int j = 0; j < numberOfNodes; j++){
					adjacencyMatrix[i][j] = scanner.nextInt();
				}
				System.out.println("Enter the destination for the graph");
				destination               = scanner.nextInt();
				Iterative iterative       = new Iterative();
				iterative.iterativeDeeping(adjacencyMatrix, destination); 
			}
		}catch(InputMismatchException inputMismatch){
			System.out.println("Wrong input");
		}
		scanner.close();
	}
}