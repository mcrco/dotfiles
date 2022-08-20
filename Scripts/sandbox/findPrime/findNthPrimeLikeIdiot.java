import java.io.*;
import java.util.*;

public class findNthPrimeLikeIdiot {

	// Global Variables
	static int n;

	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		// Declaring Variables	
		n = Integer.parseInt(st.nextToken());

		
		// Start timer
		long startTime = System.nanoTime();


		int numPrimesSoFar = 1;
		// Only checking odds cuz aint nobody got time for evens
		for (long i = 3; numPrimesSoFar <= n; i += 2) {
			if (numPrimesSoFar == n) {
				System.out.println(Math.max(2, i - 2));
				break;
			}
			if (isPrime(i)) {
				numPrimesSoFar++;
			}
		}
		
		// Stop timer
		long endTime = System.nanoTime();
		double timeTaken = ((double)endTime - (double)startTime) / 1000000000.0;
		System.out.println(timeTaken + " seconds elapsed");
	}

	// function to check if number is prime
	private static boolean isPrime(long num) {
		int sqrtNum = (int)Math.sqrt(num); // we will use this later
		if (num % 2 == 0) return false;
		// only check if number is divisible by any odds < sqrt(num) for SPEEEED
		for (int divisor = 3; divisor < sqrtNum; divisor += 2) {
			if (num % divisor == 0) return false;
		}
		
		// Nice! This number is prime
		return true;
	}
}

