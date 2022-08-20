import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class twentyfour {

	static int[] nums = new int[4];

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		for (int i = 0; i < 4; i++) {
			nums[i] = Integer.parseInt(br.readLine());
		}

		generatePermutations("");
		generateOperations("");
			
		System.out.println(permutations.size());

		for (String permutation : permutations) {
			for (String operation : operations) {
				if (solve(permutation, operation) == 24) {
					printString(permutation, operation);
				}
				printString(permutation, operation);
				printString(, operation);
			}
		}
	}
	
	static ArrayList<String> permutations = new ArrayList<>();
	static ArrayList<String> operations = new ArrayList<>();

	private static void generatePermutations(String curr) {
		if (curr.length() == 4) {
			permutations.add(curr);
			return;
		}

		for (int i = 0; i < 4; i++) {
			if (!curr.contains(i + "")) {
				generatePermutations(curr + i);
			}
		}
	}
	
	private static void generateOperations(String curr) {
		if (curr.length() == 3) {
			permutations.add(curr);
			return;
		}

		for (int i = 0; i < 4; i++) {
			generateOperations(curr + i);
		}
	}

	public static double solve(String permutation, String operation) {
		double a = nums[Integer.parseInt(permutation.substring(0, 1))];
		double b = nums[Integer.parseInt(permutation.substring(1, 2))];
		double c = nums[Integer.parseInt(permutation.substring(2, 3))];
		double d = nums[Integer.parseInt(permutation.substring(3, 4))];
		
		int operation1 = Integer.parseInt(operation.substring(0, 1));
		int operation2 = Integer.parseInt(operation.substring(1, 2));
		int operation3 = Integer.parseInt(operation.substring(2, 3));

		double firstHalf = operate(a, b, operation1);
		double secondHalf = operate(c, d, operation2);

		return operate(firstHalf, secondHalf, operation3);
	}

	public static double operate(double a, double b, int operationType) {
		switch (operationType) {
			case 0:
				return a + b;
			case 1: 
				return a - b;
			case 3: 
				return a * b;
			case 4:
				return a / b;
			default:
				return 0;
		}
	}
	
	private static void printString(String permutation, String operation) {
		String ans = "";
		for (int i = 0; i < 3; i++) {
			ans += permutation.charAt(i) + " " + operation.charAt(i) + " ";
		}
		ans += permutation.charAt(3);

		System.out.println(ans);
	}
}
