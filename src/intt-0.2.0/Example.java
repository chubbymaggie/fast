
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import uk.ac.open.crc.intt.IdentifierNameTokeniserFactory;
import uk.ac.open.crc.intt.IdentifierNameTokeniser;

// a simple class to tokenise identifier names
// from a file with one name per line.
//
public class Example {
	public static void main(String[] args) {
		if (args.length != 1) {
			System.err.println("Requires the name of an input file as the first argument");
			System.exit(1);
		}
		
		IdentifierNameTokeniserFactory factory = new IdentifierNameTokeniserFactory();
		
		IdentifierNameTokeniser tokeniser = factory.create();
		
		try {
			BufferedReader inputFile = new BufferedReader(new FileReader(new File(args[0])));
			
			String line;
			String[] tokens;
			while (true) {
				line = inputFile.readLine();
				if (line == null) {
                    break;
                }
                
                tokens = tokeniser.tokenise(line);
                
                for (int i = 0; i < tokens.length; i++) {
                	System.out.print(tokens[i]);
                	if (i < tokens.length - 1) {
                		System.out.print(" ");
                	}
                }
                System.out.println();
			}
			
			inputFile.close();
		}
		catch (IOException ioEx) {
			System.err.println(ioEx.getMessage());
			System.exit(2);
		}
	}
}
