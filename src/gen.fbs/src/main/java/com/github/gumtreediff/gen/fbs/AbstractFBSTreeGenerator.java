package com.github.gumtreediff.gen.fbs;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.lang.Exception;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.List;
import java.util.Map;

import com.github.gumtreediff.gen.TreeGenerator;
import com.github.gumtreediff.tree.ITree;
import com.github.gumtreediff.tree.TreeContext;

import com.github.gumtreediff.gen.Register;
import com.github.gumtreediff.io.ActionsIoUtils;

import _fast.Data;
import _fast.Element;
import _fast._Element.Kind;

@Register(id = "flatbuffers", accept = "\\.fbs")
public class AbstractFBSTreeGenerator extends TreeGenerator {

    private Deque<ITree> trees = new ArrayDeque<>();

    protected static Map<Integer, Integer> chars;

    public AbstractFBSTreeGenerator() {
    }

    @Override
    public TreeContext generate(Reader r) throws IOException {
         TreeContext context = new TreeContext();
         return context;
    }

    static int pos = 0;
    static int id = 1;
    @Override
    public TreeContext generateFromFile(String input) throws IOException {
	    File file = new File(input);
	    byte[] data = null;
	    RandomAccessFile f = null;
	    try{
	      f = new RandomAccessFile(file, "r");
	      data = new byte[(int)f.length()];
	      f.readFully(data);
	      f.close();
	    } catch(IOException e){
	      System.out.println("read data failed");
	      return null;
	    }
	    ByteBuffer bb = ByteBuffer.wrap(data);
	    Data dataRecord = Data.getRootAsData(bb);
	    Element element = dataRecord.RecordType().element();
            TreeContext context = new TreeContext();
	    try {
		    id = 1;
		    pos = 0;
		    buildTree(context, element);
	    } catch (Exception e) {
		    e.printStackTrace();
	    }
	    trees.clear();
	    if (ActionsIoUtils.src_path == null) 
		    ActionsIoUtils.src_path = input;
	    else
		    ActionsIoUtils.dst_path = input;
            return context;
    }

    @SuppressWarnings("unchecked")
    protected void buildTree(TreeContext context, _fast.Element element) throws Exception {
            int type = element.type().kind();
            String tokenName = _fast._Element.Kind.name(type);
	    String text = element.text();
	    String tail = element.tail();
	    int length = text!=null? text.length() : 0;
	    int start = pos;
	    // System.out.println(tokenName);
            ITree t = context.createTree(type, text, tokenName);
	    pos += length;
            if (trees.isEmpty())
                context.setRoot(t);
            else
                t.setParentAndUpdateChildren(trees.peek());
            if (element.childLength() > 0) {
                trees.push(t);
                for (int i = 0; i < element.childLength(); i++)
                    buildTree(context, element.child(i));
                trees.pop();
            }
	    pos += tail!=null? tail.length() : 0;
            t.setPos(start);
            t.setLength(pos - start);
	    t.setId(id++);
    }
}
