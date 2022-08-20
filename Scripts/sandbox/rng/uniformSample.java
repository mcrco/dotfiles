import java.io.*;
import java.util.*;

public class uniformSample {
	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Enter number of rounds");
		int n = Integer.parseInt(br.readLine());
		System.out.println("Enter lower bound of range");
		int min = Integer.parseInt(br.readLine());
		System.out.println("Enter upperbound of range");
		int max = Integer.parseInt(br.readLine());

		ArrayList<Integer> chosen = new ArrayList<>();
		String[] histogram = new String[max - min + 1];
		for (int i = 0; i <= max - min; i++) {
			histogram[i] = min + i + "";
			for (int j = 0; j < 7 - numDigits(min + i); j++) {
				histogram[i] += " ";
			} 
			histogram[i] += "|";
		}
		for (int round = 1; round <= n; round++) {
			chooseNextNumber(chosen, round, min, max);
			histogram[chosen.get(round - 1) - min] += "*";
		}

		for (int i = 0; i < max - min + 1; i++) {
			System.out.println(histogram[i]);
		}	
	}

	private static void chooseNextNumber(ArrayList<Integer> chosen, int round, int min, int max) {
		int range = max - min;
		int[] numChosenInSection = new int[round];
		for (Integer chosenNumber : chosen) {
			int relativeChosenNumber = chosenNumber - min;
			int sectionIndex = sectionOf(relativeChosenNumber, range, round) - 1;
			numChosenInSection[sectionIndex]++;		
		}

		int numLeastChosen = numChosenInSection[0]; 
		ArrayList<Integer> sectionsWithLeastChosen = new ArrayList<>();
		sectionsWithLeastChosen.add(0);
		for (int i = 1; i < round; i++) {
			if (numChosenInSection[i] == numLeastChosen) {
				sectionsWithLeastChosen.add(i);
			} else if (numChosenInSection[i] < numLeastChosen) {
				numLeastChosen = numChosenInSection[i];
				sectionsWithLeastChosen.clear();
				sectionsWithLeastChosen.add(i);
			}
		}

		Random rng = new Random();
		// choose a random section out of possibly multiple setions with least chosen amount
		int sectionWithLeastChosen = sectionsWithLeastChosen.get(rng.nextInt(sectionsWithLeastChosen.size()));
		double minOfSection = min + (double)sectionWithLeastChosen * range / round;
		int randNumInLeastChosenSection =  (int)Math.round(minOfSection + Math.random() * range / round);
		chosen.add(randNumInLeastChosenSection);
	}

	// binary search for which section of range the number is in
	private static int sectionOf(int num, int range, int numSections) {
		int low = 1;
		int high = numSections;
		while (low < high) {
			int mid = (low + high) / 2;
			if ((double)mid * range / numSections < num) {
				low = mid + 1;
			}
			else {
				high = mid;
			}
		}
		return low;
	} 

	private static int numDigits(int n) {
		String str = n + "";
		return str.length();
	}
}

