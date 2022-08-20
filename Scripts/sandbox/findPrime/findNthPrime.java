import java.io.*;
import java.util.*;

public class findNthPrime {

	// Global Variables
	static int n;
	static ArrayList<Long> primes = new ArrayList<>();

	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		// Declaring Variables	
		n = Integer.parseInt(st.nextToken());

		
		// Start timer
		long startTime = System.nanoTime();

		int numPrimesSoFar = 0;
		for (long i = 2; numPrimesSoFar < n; i++) {
			if (isPrime(i)) {
				numPrimesSoFar++;
			}
			if (numPrimesSoFar == n) {
				System.out.println(i);
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
		// only check if number is divisible by any prime since this is faster
		for (long prime : primes) {
			// we only need to check divisibilty by numbers < sqrt(x) for SPEEED
			if (prime > sqrtNum) break;
			if (num % prime == 0) return false;
		}
		
		// Nice! This number is prime
		primes.add(num); // recording primes as we go
		return true;
	}
}

