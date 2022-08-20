import java.io.*;
import java.util.*;

public class coingame124 {

	// Global Variables
	static int n;
	static int[] dp;

	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		
		n = Integer.parseInt(st.nextToken());
		dp = new int[n + 1];
		Arrays.fill(dp, -1);
	}
	
	static int maxScore(int numCoinsLeft) {
		// Base case
		if (numCoinsLeft <= 4) {
			return numCoinsLeft;
		}
		
		// Already calculated
		if (dp[numCoinsLeft] != -1) {
			return dp[numCoinsLeft];
		}
		
		// Transition
		int scoreTakingOneCoin = n - maxScore(numCoinsLeft - 1);
		int scoreTakingTwoCoins = n - maxScore(numCoinsLeft - 2);
		int scoreTakingThreeCoins = n - maxScore(numCoinsLeft - 4);
		return Math.min(Math.min(scoreTakingOneCoin, scoreTakingTwoCoins), scoreTakingThreeCoins);
	}
}

