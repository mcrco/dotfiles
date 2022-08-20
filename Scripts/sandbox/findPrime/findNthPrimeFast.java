import java.io.*;
import java.util.*;

public class findNthPrimeFast {

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


		primes.add(2L);
		int numPrimesSoFar = 1;
		// Only checking odds cuz aint nobody got time for evens
		for (long i = 3; numPrimesSoFar < n; i += 2) {
			if (numPrimesSoFar == n) {
				System.out.println(Math.max(2, i - 2));
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

