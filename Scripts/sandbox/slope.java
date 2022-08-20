import java.io.*;
import java.util.*;

public class slope {

	public static void main(String[] args) throws IOException {
		// Input
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		// Declaring Variables	
		double x1 = Double.parseDouble(st.nextToken());
		double y1 = Double.parseDouble(st.nextToken());
		double x2 = Double.parseDouble(st.nextToken());
		double y2 = Double.parseDouble(st.nextToken());
		
		System.out.println((y2 - y1) / (x2 - x1));
	}
}

