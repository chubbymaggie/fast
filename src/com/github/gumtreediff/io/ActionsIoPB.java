package com.github.gumtreediff.io;

import com.github.gumtreediff.actions.model.*;
import com.github.gumtreediff.io.TreeIoUtils.AbstractSerializer;
import com.github.gumtreediff.matchers.Mapping;
import com.github.gumtreediff.matchers.MappingStore;
import com.github.gumtreediff.tree.ITree;
import com.github.gumtreediff.tree.TreeContext;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.List;

public final class ActionsIoPB {

    private ActionsIoPB() {
    }

    public static ActionSerializer toPB(TreeContext sctx, List<Action> actions,
                                        MappingStore mappings, 
				        fast.Fast.Delta.Builder delta) throws IOException {
        return new ActionSerializer(sctx, mappings, actions, delta) {

            @Override
            protected ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception {
                return new PBFormatter(ctx, writer, delta);
            }

            @Override
            protected ActionFormatter newFormatter2(TreeContext ctx, Writer writer,
			    fast.Fast.Delta.Builder delta) throws Exception {
                return new PBFormatter(ctx, writer, delta);
            }
        };
    }

    public abstract static class ActionSerializer extends AbstractSerializer {
        final TreeContext context;
        final MappingStore mappings;
        final List<Action> actions;
	final fast.Fast.Delta.Builder delta;

        ActionSerializer(TreeContext context, MappingStore mappings, 
			List<Action> actions, fast.Fast.Delta.Builder delta) {
            this.context = context;
            this.mappings = mappings;
            this.actions = actions;
	    this.delta = delta;
        }

        protected abstract ActionFormatter newFormatter(TreeContext ctx, Writer writer) throws Exception;
        protected abstract ActionFormatter newFormatter2(TreeContext ctx, Writer writer, fast.Fast.Delta.Builder delta) throws Exception;

        @Override
        public void writeTo(Writer writer) throws Exception {
		System.out.println("write to ... ");
            ActionFormatter fmt = newFormatter2(context, writer, delta);
            // Start the output
            fmt.startOutput();

            // Write the matches
            fmt.startMatches();
            for (Mapping m: mappings) {
                fmt.match(m.getFirst(), m.getSecond());
            }
            fmt.endMatches();

            // Write the actions
            fmt.startActions();
            for (Action a : actions) {
                ITree src = a.getNode();
                if (a instanceof Move) {
                    ITree dst = mappings.getDst(src);
                    fmt.moveAction(src, dst.getParent(), ((Move) a).getPosition());
                } else if (a instanceof Update) {
                    ITree dst = mappings.getDst(src);
                    fmt.updateAction(src, dst);
                } else if (a instanceof Insert) {
                    ITree dst = a.getNode();
                    if (dst.isRoot())
                        fmt.insertRoot(src);
                    else
                        fmt.insertAction(src, dst.getParent(), dst.getParent().getChildPosition(dst));
                } else if (a instanceof Delete) {
                    fmt.deleteAction(src);
                }
            }
            fmt.endActions();

            // Finish up
            fmt.endOutput();
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

    static class PBFormatter implements ActionFormatter {
        final Writer writer;
        final TreeContext context;
	final fast.Fast.Delta.Builder delta;

        public PBFormatter(TreeContext ctx, Writer writer, fast.Fast.Delta.Builder delta) {
            this.context = ctx;
            this.writer = writer;
	    this.delta = delta;
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
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.MATCH);
		fast.Fast.Delta.Diff.Match.Builder match = fast.Fast.Delta.Diff.Match.newBuilder();
		match.setSrc(srcNode.getId());
		match.setDst(destNode.getId());
		diff.setMatch(match);
        }

        @Override
        public void endMatches() throws Exception {
        }

        @Override
        public void startActions() throws Exception {
        }

        @Override
        public void insertRoot(ITree node) throws Exception {
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.ADD);
		fast.Fast.Delta.Diff.Add.Builder add = fast.Fast.Delta.Diff.Add.newBuilder();
		add.setSrc(node.getId());
		add.setDst(0);
		add.setPosition(0);
		diff.setAdd(add);
        }

        @Override
        public void insertAction(ITree node, ITree parent, int index) throws Exception {
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.ADD);
		fast.Fast.Delta.Diff.Add.Builder add = fast.Fast.Delta.Diff.Add.newBuilder();
		add.setSrc(node.getId());
		add.setDst(parent.getId());
		add.setPosition(index);
		diff.setAdd(add);
        }

        @Override
        public void moveAction(ITree src, ITree dst, int position) throws Exception {
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.MOVE);
		fast.Fast.Delta.Diff.Move.Builder move = fast.Fast.Delta.Diff.Move.newBuilder();
		move.setSrc(src.getId());
		move.setDst(dst.getId());
		move.setPosition(position);
		diff.setMove(move);
        }

        @Override
        public void updateAction(ITree src, ITree dst) throws Exception {
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.UPDATE);
		fast.Fast.Delta.Diff.Update.Builder update = fast.Fast.Delta.Diff.Update.newBuilder();
		update.setSrc(src.getId());
		update.setLabel(dst.getLabel());
		diff.setUpdate(update);
        }

        @Override
        public void deleteAction(ITree node) throws Exception {
		fast.Fast.Delta.Diff.Builder diff = delta.addDiffBuilder(); 
		diff.setType(fast.Fast.Delta.Diff.DeltaType.DEL);
		fast.Fast.Delta.Diff.Del.Builder del = fast.Fast.Delta.Diff.Del.newBuilder();
		del.setSrc(node.getId());
		diff.setDel(del);
        }

        @Override
        public void endActions() throws Exception {
        }

        private void write(String fmt, Object... objs) throws IOException {
            writer.append(String.format(fmt, objs));
            writer.append("\n");
        }
    }

}
