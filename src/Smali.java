// import com.github.gumtreediff.client.diff.PBDiff;
// import com.github.gumtreediff.client.Run;

import com.github.gumtreediff.actions.ActionGenerator;
import com.github.gumtreediff.actions.model.Action;
import com.github.gumtreediff.io.ActionsIoPB;
import com.github.gumtreediff.matchers.Matcher;
import com.github.gumtreediff.matchers.Matchers;
import com.github.gumtreediff.matchers.MappingStore;
import com.github.gumtreediff.io.TreeIoUtils.AbstractSerializer;

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

    /**
     * Two file arguments expected:
     *    Smali file1.smali file2.smali file3.pb
     *  - Output the differences between file1 and file2 into protobuf form
     *    Smali file1.smali file2.pb
     *  - Output the smali file1 into protobuf file2
     */
    public static void main(String args[]) throws Exception {

	if (args.length == 2 && args[1].endsWith(".pb")) {
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
	}
	if (args.length == 3 && args[1].endsWith(".smali")) {
		TreeContext src = Generators.getInstance().getTree(args[0]); // System.out.println(src);
		TreeContext dst = Generators.getInstance().getTree(args[1]); // System.out.println(dst);

		System.out.println(Matchers.getInstance().getClass().getName());
		// Matcher matcher = Matchers.getInstance().getMatcher("xy", src.getRoot(), dst.getRoot());
		// Matcher matcher = Matchers.getInstance().getMatcher("change-distiller", src.getRoot(), dst.getRoot());
		Matcher matcher = Matchers.getInstance().getMatcher("gumtree", src.getRoot(), dst.getRoot());

		matcher.match();
		ActionGenerator g = new ActionGenerator(src.getRoot(), dst.getRoot(), matcher.getMappings());
	        g.generate();
	        List<Action> actions = g.getActions();
		try {
		    fast.Fast.Delta.Builder delta = fast.Fast.Delta.newBuilder();
		    delta.setSrc(args[0]);
		    delta.setDst(args[1]);
		    ActionsIoPB.toPB(src, actions, matcher.getMappings(), delta).writeTo(args[2]);
		    FileOutputStream output = new FileOutputStream(args[2]);
		    delta.build().writeTo(output);
		    output.close();
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}
    }

}
