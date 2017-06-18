import com.github.gumtreediff.gen.Generators;
import com.github.gumtreediff.gen.Registry;
import com.github.gumtreediff.gen.TreeGenerator;
import com.github.gumtreediff.tree.ITree;
import com.github.gumtreediff.tree.TreeContext;
import fast.Fast;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.Reader;
import java.lang.Exception;
import java.util.ArrayDeque;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Deque;
import java.util.List;
import java.util.Map;
import org.antlr.runtime.*;
import org.antlr.runtime.tree.CommonTree;
import org.jf.smali.smaliFlexLexer;
import org.jf.smali.smaliParser;
import org.reflections.Reflections;

public class Smali {

    public static void initGenerators() {
        Reflections reflections = new Reflections("com.github.gumtreediff.gen");
        reflections.getSubTypesOf(TreeGenerator.class).forEach(
                gen -> {
                    com.github.gumtreediff.gen.Register a =
                            gen.getAnnotation(com.github.gumtreediff.gen.Register.class);
                    if (a != null)
                        Generators.getInstance().install(gen, a);
            });
    }

    static {
        initGenerators();
    }

    public static void savePBfromITree(fast.Fast.Element.Builder element, ITree t) {
        int kind = t.getType();
        String label = t.getLabel();
        if (label != ITree.NO_LABEL) {
	    element.setText(label);
	}
	// element.setKind(kind);
	element.setKindValue(kind);
	element.setPos(t.getPos());
	element.setLength(t.getLength());
        if (t.getChildren().size() > 0) {
            for (ITree it : (List<ITree>) t.getChildren()) {
		fast.Fast.Element.Builder child = fast.Fast.Element.newBuilder();
                savePBfromITree(child, it);
		element.addChild(child);
	    }
        }
    }

    static Deque<ITree> trees = new ArrayDeque<>();

    public static ITree saveITreeFromPB(fast.Fast.Element element, TreeContext context) {
        // int kind = element.getKind();
        int kind = element.getKindValue();
	String label = element.getText();
        ITree t = context.createTree(kind, label, "");

        int pos = element.getPos();
        int length = element.getLength();
        t.setPos(pos);
        t.setLength(length);

        if (!trees.isEmpty())
            t.setParentAndUpdateChildren(trees.peek());

        if (element.getChildCount() > 0) {
            trees.push(t);
            for (fast.Fast.Element c: (List<fast.Fast.Element>) element.getChildList())
                saveITreeFromPB(c, context);
            trees.pop();
        }
	return t;
    }

    public static void main(String args[]) throws IOException {

        TreeContext src = Generators.getInstance().getTree(args[0]); // System.out.println(src);
	ITree t = src.getRoot();

	fast.Fast.Element.Builder root_element = fast.Fast.Element.newBuilder();

	fast.Fast.Element.Unit.Builder unit = root_element.getUnitBuilder();
	unit.setFilename(args[0]);

	fast.Fast.Element.Builder element = fast.Fast.Element.newBuilder();
	savePBfromITree(element, src.getRoot());
	root_element.addChild(element);

	FileOutputStream output = new FileOutputStream(args[1]);
	root_element.build().writeTo(output);
	output.close();

	FileInputStream input = new FileInputStream(args[1]);
	fast.Fast.Element e = fast.Fast.Element.parseFrom(input);
	input.close();
	t = saveITreeFromPB(e, src);
	src.setRoot(t);
	System.out.println(src);
    }

}
