/*
 * This file is part of GumTree.
 *
 * GumTree is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GumTree is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with GumTree.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright 2011-2015 Jean-Rémy Falleri <jr.falleri@gmail.com>
 * Copyright 2011-2015 Floréal Morandat <florealm@gmail.com>
 */

package com.github.gumtreediff.io;

import com.github.gumtreediff.actions.model.*;
import com.github.gumtreediff.io.TreeIoUtils.AbstractSerializer;
import com.github.gumtreediff.matchers.Mapping;
import com.github.gumtreediff.matchers.MappingStore;
import com.github.gumtreediff.tree.ITree;
import com.github.gumtreediff.tree.TreeContext;
import com.google.gson.internal.Excluder;
import com.google.gson.stream.JsonWriter;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.IOException;
import java.io.Writer;
import java.io.FileOutputStream;
import java.io.DataOutputStream;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import fast.Fast;
import _fast.Data;
import com.google.flatbuffers.FlatBufferBuilder;
import java.util.ArrayList;

public final class ActionsIoUtils {

    private ActionsIoUtils() {
    }

    public static String src_path;
    public static String dst_path;

    public static ActionSerializer toText(TreeContext sctx, List<Action> actions,
                                          MappingStore mappings) throws IOException {
        return new ActionSerializer(sctx, mappings, actions) {

            @Override
            protected ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception {
                return new TextFormatter(ctx, writer);
            }
        };
    }

    public static ActionSerializer toXml(TreeContext sctx, List<Action> actions,
                                         MappingStore mappings) throws IOException {
        return new ActionSerializer(sctx, mappings, actions) {

            @Override
            protected ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception {
                return new XmlFormatter(ctx, writer);
            }
        };
    }

    public static ActionSerializer toJson(TreeContext sctx, List<Action> actions,
                                              MappingStore mappings) throws IOException {
        return new ActionSerializer(sctx, mappings, actions) {

            @Override
            protected ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception {
                return new JsonFormatter(ctx, writer);
            }
        };
    }

    public abstract static class ActionSerializer extends AbstractSerializer {
        final TreeContext context;
        final MappingStore mappings;
        final List<Action> actions;

        ActionSerializer(TreeContext context, MappingStore mappings, List<Action> actions) {
            this.context = context;
            this.mappings = mappings;
            this.actions = actions;
        }

        protected abstract ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception;

        @Override
        public void writeTo(Writer writer) throws Exception {
	    boolean update_pb = false;
	    boolean update_fbs = false;
	    if (context != null && context.root!=null && src_path != null) {
		    if (src_path.lastIndexOf(".pb") >= 0)
			    update_pb = true;
		    if (src_path.lastIndexOf(".fbs") >= 0)
			    update_fbs = true;
	    }
	    String src_filename = null;
	    String dst_filename = null;
	    String delta_filename = null;
	    if (update_pb) {
			if (src_path.indexOf("/")>=0)
				src_filename = src_path.substring(src_path.lastIndexOf("/")+1);
			else
				src_filename = src_path;
			if (dst_path.indexOf("/")>=0)
				dst_filename = dst_path.substring(dst_path.lastIndexOf("/")+1);
			else
				dst_filename = dst_path;
			delta_filename = src_filename.substring(0, src_filename.lastIndexOf(".pb")) + 
				dst_filename.substring(0, dst_filename.lastIndexOf(".pb")) + 
				"-diff.pb";
	    }
	    if (update_fbs) {
			if (src_path.indexOf("/")>=0)
				src_filename = src_path.substring(src_path.lastIndexOf("/")+1);
			else
				src_filename = src_path;
			if (dst_path.indexOf("/")>=0)
				dst_filename = dst_path.substring(dst_path.lastIndexOf("/")+1);
			else
				dst_filename = dst_path;
			delta_filename = src_filename.substring(0, src_filename.lastIndexOf(".fbs")) + 
				dst_filename.substring(0, dst_filename.lastIndexOf(".fbs")) + 
				"-diff.fbs";
	    }
            ActionFormatter fmt = newFormatter(context, writer);
            // Start the output
            fmt.startOutput();

	    fast.Fast.Delta.Builder delta_pb = null; 
	    if (update_pb) {
		    delta_pb = fast.Fast.Delta.newBuilder();
	    }
	    FlatBufferBuilder fbb = null;
	    int srcId = 0;
	    int dstId = 0;
	    ArrayList<Integer> vec = new ArrayList<Integer>();
	    if (update_fbs) {
		    // fbb.clear();
		    fbb = new FlatBufferBuilder(1);
	    }
	    if (src_path != null && dst_path!=null) {
		    if (update_pb) {
			    delta_pb.setSrc(src_path);
			    delta_pb.setDst(dst_path);
		    }
		    if (update_fbs) {
			srcId = fbb.createString(src_path);
			dstId = fbb.createString(dst_path);
			vec.clear();
		    }
		    // Write the matches
		    fmt.startMatches();
		    for (Mapping m: mappings) {
			if (update_pb) {
				fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
				dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.MATCH);
				fast.Fast.Delta.Diff.Match.Builder mbuilder = dbuilder.getMatchBuilder();
				mbuilder.setSrc(m.getFirst().getId());
				mbuilder.setDst(m.getSecond().getId());
			}
			if (update_fbs) {
				int type = _fast._Delta._Diff.DeltaType.MATCH;
				int match = _fast._Delta._Diff.Match.createMatch(fbb, m.getFirst().getId(), m.getSecond().getId());
				int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, 0, 0, match, 0);
				int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
				vec.add(diff);
			}
			fmt.match(m.getFirst(), m.getSecond());
		    }
		    fmt.endMatches();

		    // Write the actions
		    fmt.startActions();
		    for (Action a : actions) {
			ITree src = a.getNode();
			if (a instanceof Move) {
			    ITree dst = mappings.getDst(src);
			    if (update_pb) {
				    fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
				    dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.MOVE);
				    fast.Fast.Delta.Diff.Move.Builder mbuilder = dbuilder.getMoveBuilder();
				    mbuilder.setSrc(src.getId());
				    mbuilder.setDst(dst.getParent().getId());
				    mbuilder.setPosition(((Move) a).getPosition());
			    }
			    if (update_fbs) {
					int type = _fast._Delta._Diff.DeltaType.MOVE;
					int move = _fast._Delta._Diff.Move.createMove(fbb, src.getId(), dst.getId(),
							((Move) a).getPosition());
					int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, 0, 0, move, 0);
					int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
					vec.add(diff);
			    }
			    fmt.moveAction(src, dst.getParent(), ((Move) a).getPosition());
			} else if (a instanceof Update) {
			    ITree dst = mappings.getDst(src);
			    if (update_pb) {
				    fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
				    dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.UPDATE);
				    fast.Fast.Delta.Diff.Update.Builder mbuilder = dbuilder.getUpdateBuilder();
				    mbuilder.setSrc(src.getId());
				    if (dst!=null) {
					    mbuilder.setDst(dst.getId());
				    }
			    }
			    if (update_fbs) {
					int type = _fast._Delta._Diff.DeltaType.UPDATE;
					int update = _fast._Delta._Diff.Update.createUpdate(fbb, src.getId(), dst!=null? dst.getId(): 0);
					int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, 0, 0, 0, update);
					int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
					vec.add(diff);
			    }
			    fmt.updateAction(src, dst);
			} else if (a instanceof Insert) {
			    ITree dst = a.getNode();
			    if (dst.isRoot()) {
				if (update_pb) {
					fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
					dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.ADD);
					fast.Fast.Delta.Diff.Add.Builder mbuilder = dbuilder.getAddBuilder();
					mbuilder.setSrc(src.getId());
				}
			        if (update_fbs) {
					int type = _fast._Delta._Diff.DeltaType.ADD;
					int add = _fast._Delta._Diff.Add.createAdd(fbb, src.getId(), 0, 0);
					int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, add, 0, 0, 0);
					int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
					vec.add(diff);
			        }
				fmt.insertRoot(src);
			    } else {
			        if (update_pb) {
					fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
					dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.ADD);
					fast.Fast.Delta.Diff.Add.Builder mbuilder = dbuilder.getAddBuilder();
					mbuilder.setSrc(src.getId());
					mbuilder.setDst(dst.getParent().getId());
					mbuilder.setPosition(dst.getParent().getChildPosition(dst));
				}
			        if (update_fbs) {
					int type = _fast._Delta._Diff.DeltaType.ADD;
					int add = _fast._Delta._Diff.Add.createAdd(fbb, src.getId(), 
							dst.getParent().getId(), dst.getParent().getChildPosition(dst));
					int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, add, 0, 0, 0);
					int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
					vec.add(diff);
			        }
				fmt.insertAction(src, dst.getParent(), dst.getParent().getChildPosition(dst));
			    }
			} else if (a instanceof Delete) {
				if (update_pb) {
					fast.Fast.Delta.Diff.Builder dbuilder = delta_pb.addDiffBuilder();
					dbuilder.setType(fast.Fast.Delta.Diff.DeltaType.DEL);
					fast.Fast.Delta.Diff.Del.Builder mbuilder = dbuilder.getDelBuilder();
					mbuilder.setSrc(src.getId());
				}
				if (update_fbs) {
					int type = _fast._Delta._Diff.DeltaType.DEL;
					int del = _fast._Delta._Diff.Del.createDel(fbb, src.getId());
					int delta = _fast._Delta._Diff.Anonymous2.createAnonymous2(fbb, 0, 0, del, 0, 0);
					int diff = _fast._Delta.Diff.createDiff(fbb, type, delta);
					vec.add(diff);
				}
				fmt.deleteAction(src);
			}
		    }
		    fmt.endActions();
	    }

            // Finish up
            fmt.endOutput();
	    if (update_pb && delta_pb!=null) {
		fast.Fast.Data.Builder data_element = fast.Fast.Data.newBuilder();
		data_element.setDelta(delta_pb);
		FileOutputStream output = new FileOutputStream(delta_filename);
		data_element.build().writeTo(output);
		output.close();
	    }
	    if (update_fbs && fbb!=null) {
		    int [] rec = new int[vec.size()];
		    for (int i=0; i<vec.size(); i++) {
			    rec[i] = vec.get(i);
		    }
		    int diff = _fast.Delta.createDiffVector(fbb, rec);
		    int delta_Id = _fast.Delta.createDelta(fbb, srcId, dstId, diff);
		    int anonymous = _fast._Data.Anonymous4.createAnonymous4(fbb, 0, 0, delta_Id, 0, 0, 0);
		    int data = Data.createData(fbb, anonymous);
		    try {
		       DataOutputStream os = new DataOutputStream(new FileOutputStream(delta_filename));
		       fbb.finish(data);
		       os.write(fbb.dataBuffer().array(), fbb.dataBuffer().position(), fbb.offset());
		       os.close();
		    } catch(java.io.IOException e) {
		       System.out.println("FlatBuffers test: couldn't write file");
		       return;
		    }
	    }
	}
    }

    interface ActionFormatter {
        void startOutput() throws Exception;

        void endOutput() throws Exception;

        void startMatches() throws Exception;

        void match(ITree srcNode, ITree destNode) throws Exception;

        void endMatches() throws Exception;

        void startActions() throws Exception;

        void insertRoot(ITree node) throws Exception;

        void insertAction(ITree node, ITree parent, int index) throws Exception;

        void moveAction(ITree src, ITree dst, int index) throws Exception;

        void updateAction(ITree src, ITree dst) throws Exception;

        void deleteAction(ITree node) throws Exception;

        void endActions() throws Exception;
    }

    static class XmlFormatter implements ActionFormatter {
        final TreeContext context;
        final XMLStreamWriter writer;

        XmlFormatter(TreeContext context, Writer w) throws XMLStreamException {
            XMLOutputFactory f = XMLOutputFactory.newInstance();
            writer = new IndentingXMLStreamWriter(f.createXMLStreamWriter(w));
            this.context = context;
        }

        @Override
        public void startOutput() throws XMLStreamException {
            writer.writeStartDocument();
        }

        @Override
        public void endOutput() throws XMLStreamException {
            writer.writeEndDocument();
        }

        @Override
        public void startMatches() throws XMLStreamException {
            writer.writeStartElement("matches");
        }

        @Override
        public void match(ITree srcNode, ITree destNode) throws XMLStreamException {
            writer.writeEmptyElement("match");
            writer.writeAttribute("src", Integer.toString(srcNode.getId()));
            writer.writeAttribute("dest", Integer.toString(destNode.getId()));
        }

        @Override
        public void endMatches() throws XMLStreamException {
            writer.writeEndElement();
        }

        @Override
        public void startActions() throws XMLStreamException {
            writer.writeStartElement("actions");
        }

        @Override
        public void insertRoot(ITree node) throws Exception {
            start(Insert.class, node);
            end(node);
        }

        @Override
        public void insertAction(ITree node, ITree parent, int index) throws Exception {
            start(Insert.class, node);
            writer.writeAttribute("parent", Integer.toString(parent.getId()));
            writer.writeAttribute("at", Integer.toString(index));
            end(node);
        }

        @Override
        public void moveAction(ITree src, ITree dst, int index) throws XMLStreamException {
            start(Move.class, src);
            writer.writeAttribute("parent", Integer.toString(dst.getId()));
            writer.writeAttribute("at", Integer.toString(index));
            end(src);
        }

        @Override
        public void updateAction(ITree src, ITree dst) throws XMLStreamException {
            start(Update.class, src);
            writer.writeAttribute("label", dst.getLabel());
            end(src);
        }

        @Override
        public void deleteAction(ITree node) throws Exception {
            start(Delete.class, node);
            end(node);
        }

        @Override
        public void endActions() throws XMLStreamException {
            writer.writeEndElement();
        }

        private void start(Class<? extends Action> name, ITree src) throws XMLStreamException {
            writer.writeEmptyElement(name.getSimpleName().toLowerCase());
            writer.writeAttribute("tree", Integer.toString(src.getId()));
        }

        private void end(ITree node) throws XMLStreamException {
//            writer.writeEndElement();
        }
    }

    static class TextFormatter implements ActionFormatter {
        final Writer writer;
        final TreeContext context;

        public TextFormatter(TreeContext ctx, Writer writer) {
            this.context = ctx;
            this.writer = writer;
        }

        @Override
        public void startOutput() throws Exception {
        }

        @Override
        public void endOutput() throws Exception {
        }

        @Override
        public void startMatches() throws Exception {
        }

        @Override
        public void match(ITree srcNode, ITree destNode) throws Exception {
            write("Match %s to %s", toS(srcNode), toS(destNode));
        }

        @Override
        public void endMatches() throws Exception {
        }

        @Override
        public void startActions() throws Exception {
        }

        @Override
        public void insertRoot(ITree node) throws Exception {
            write("Insert root %s", toS(node));
        }

        @Override
        public void insertAction(ITree node, ITree parent, int index) throws Exception {
            write("Insert %s into %s at %d", toS(node), toS(parent), index);
        }

        @Override
        public void moveAction(ITree src, ITree dst, int position) throws Exception {
            write("Move %s into %s at %d", toS(src), toS(dst), position);
        }

        @Override
        public void updateAction(ITree src, ITree dst) throws Exception {
            write("Update %s to %s", toS(src), dst.getLabel());
        }

        @Override
        public void deleteAction(ITree node) throws Exception {
            write("Delete %s", toS(node));
        }

        @Override
        public void endActions() throws Exception {
        }

        private void write(String fmt, Object... objs) throws IOException {
            writer.append(String.format(fmt, objs));
            writer.append("\n");
        }

        private String toS(ITree node) {
            return String.format("%s(%d)", node.toPrettyString(context), node.getId());
        }
    }

    static class JsonFormatter implements ActionFormatter {
        private final JsonWriter writer;

        JsonFormatter(TreeContext ctx, Writer writer) {

            this.writer = new JsonWriter(writer);
            this.writer.setIndent("  ");
        }

        @Override
        public void startOutput() throws IOException {
            writer.beginObject();
        }

        @Override
        public void endOutput() throws IOException {
            writer.endObject();
        }

        @Override
        public void startMatches() throws Exception {
            writer.name("matches").beginArray();
        }

        @Override
        public void match(ITree srcNode, ITree destNode) throws Exception {
            writer.beginObject();
            writer.name("src").value(srcNode.getId());
            writer.name("dest").value(destNode.getId());
            writer.endObject();
        }

        @Override
        public void endMatches() throws Exception {
            writer.endArray();
        }

        @Override
        public void startActions() throws IOException {
            writer.name("actions").beginArray();
        }

        @Override
        public void insertRoot(ITree node) throws IOException {
            start(Insert.class, node);
            end(node);
        }

        @Override
        public void insertAction(ITree node, ITree parent, int index) throws IOException {
            start(Insert.class, node);
            writer.name("parent").value(parent.getId());
            writer.name("at").value(index);
            end(node);
        }

        @Override
        public void moveAction(ITree src, ITree dst, int index) throws IOException {
            start(Move.class, src);
            writer.name("parent").value(dst.getId());
            writer.name("at").value(index);
            end(src);
        }

        @Override
        public void updateAction(ITree src, ITree dst) throws IOException {
            start(Update.class, src);
            writer.name("label").value(dst.getLabel());
            end(src);
        }

        @Override
        public void deleteAction(ITree node) throws IOException {
            start(Delete.class, node);
            end(node);
        }

        private void start(Class<? extends Action> name, ITree src) throws IOException {
            writer.beginObject();
            writer.name("action").value(name.getSimpleName().toLowerCase());
            writer.name("tree").value(src.getId());
        }

        private void end(ITree node) throws IOException {
            writer.endObject();
        }

        @Override
        public void endActions() throws Exception {
            writer.endArray();
        }
    }
}
