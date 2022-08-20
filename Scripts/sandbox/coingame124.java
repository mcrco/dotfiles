import java.io.*;
import java.util.*;

public class coingame124 {
	
	// Global Variables
	static int[] dp;

	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		
		int n = Integer.parseInt(st.nextToken());
		String first = st.nextToken();
		String second = st.nextToken();

		dp = new int[n + 1];
		Arrays.fill(dp, -1);
		
		if (numWinsWith(n) != 0) {
			System.out.println(first + " " + numWinsWith(n));
		} else {
			System.out.println(second + " " + (numWinsWith(n - 1) + numWinsWith(n - 2) + numWinsWith(n - 4)));
		}
	}
	
	static int numWinsWith(int numCoinsLeft) {
		// Base cases
		if (numCoinsLeft < 0) {
			return 0;
		}
		if (numCoinsLeft == 1) {
			return 1;
		}
		if (numCoinsLeft == 2) {
			return 1;
		}
		if (numCoinsLeft == 3) {
			return 0;
		}
		if (numCoinsLeft == 4) {
			return 3;
		}
		
		// Transition
		if (dp[numCoinsLeft] == -1) {
			dp[numCoinsLeft] = 0;
			if (numWinsWith(numCoinsLeft - 1) == 0) {
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 1 - 1);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 1 - 2);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 1 - 4);
			}
			if (numWinsWith(numCoinsLeft - 2) == 0) {
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 2 - 1);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 2 - 2);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 2 - 4);
			}
			if (numWinsWith(numCoinsLeft - 4) == 0) {
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 4 - 1);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 4 - 2);
				dp[numCoinsLeft] += numWinsWith(numCoinsLeft - 4 - 4);
			}
		}
		
		return dp[numCoinsLeft];
	}
}

