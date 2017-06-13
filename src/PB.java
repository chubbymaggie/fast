import fast.Fast;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.Exception;

public class PB {

	public static void main(String [] args) throws Exception {
		fast.Fast.Element.Unit unit = fast.Fast.Element.Unit.parseFrom(new FileInputStream(args[0]));
		System.out.println(unit);
	}
}
