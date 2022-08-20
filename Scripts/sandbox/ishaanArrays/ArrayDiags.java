public class ArrayDiags {
	public static void main(String[] args) {
		int[][] square = {
			{1, 2, 3},
			{4, 5, 6},
			{7, 8, 9}
		};
		printDiags(square);
	}

	public static void printDiags(int[][] arr) {
		int sideLength = arr.length;
		for (int col = 0; col < sideLength; col++) {
			String diag = "";
			for (int row = 0; row <= col; row++) {
				diag += arr[row][col - row] + " ";
			}
			System.out.println(diag);
		} 
		for (int row = 1; row < sideLength; row++) {
			String diag = "";
			for (int col = 0; col <= sideLength - 1 - row; col++) {
				diag += arr[row - col][sideLength - 1 - col] + " ";
			}
			System.out.println(diag);
		}
		System.out.println();
	}
}
