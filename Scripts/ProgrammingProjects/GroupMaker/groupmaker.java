import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.TreeSet;

public class groupmaker {

	static TreeMap<String, TreeSet<String>> preferences = new TreeMap<>();
	static int numPeople;
	static int[] groupOf;

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		int numPeoplePerGroup = Integer.parseInt(br.readLine());

		String temp;
		while ((temp = br.readLine()) != null) {
			StringTokenizer st = new StringTokenizer(temp);
			String personA = st.nextToken();
			String personB = st.nextToken();
			
			preferences.putIfAbsent(st.nextToken(), new TreeSet<>());
			preferences.get(personA).add(personB);
		}

		numPeople = preferences.keySet().size();
		groupOf = new int[(int)Math.ceil((double)numPeople / numPeoplePerGroup)];
	}
}
