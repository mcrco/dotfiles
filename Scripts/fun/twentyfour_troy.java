import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;


public class twentyfour_troy {

	static int[] nums = new int[4];

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		for (int i = 0; i < 4; i++) {
			nums[i] = Integer.parseInt(br.readLine());
		}


	}
}
