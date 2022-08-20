import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class matrix {
	static int[][] arr;
	
	public static void switchRows(int r1, int r2) {
		int[] temp = arr[r1];
		
		for (int i = 0; i < arr[0].length; i++) {
			arr[r1] = arr[r2][i];
		}
		
		for (int i = 0; i < arr[0].length; i++) {
			arr[r2] = temp[i];
		}
	}

	public static void addRows()


	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
	}
}
