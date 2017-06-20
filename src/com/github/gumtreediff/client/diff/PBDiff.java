package com.github.gumtreediff.client.diff;
import com.github.gumtreediff.actions.ActionGenerator; 
import com.github.gumtreediff.actions.model.Action; 
import com.github.gumtreediff.client.Option; 
import com.github.gumtreediff.client.Register; 
import com.github.gumtreediff.io.ActionsIoUtils; 
import com.github.gumtreediff.matchers.MappingStore; 
import com.github.gumtreediff.matchers.Matcher; 
import com.github.gumtreediff.tree.TreeContext; 

import java.io.IOException;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.List;
@Register(name = "pbdiff", description = "Dump actions in our protobuf format",
		        options = AbstractDiffClient.Options.class)
public class PBDiff extends AbstractDiffClient<PBDiff.Options> {
    public PBDiff(String[] args) {
	super(args);
        if (opts.format == null) {
            opts.format = OutputFormat.PB;
        }
    }
    enum OutputFormat {
        PB {
            // @Override
            ActionsIoUtils.ActionSerializer getSerializer(TreeContext sctx, List<Action> actions, MappingStore mappings)
                    throws IOException {
                return ActionsIoUtils.toText(sctx, actions, mappings);
            }
        };
    
        abstract ActionsIoUtils.ActionSerializer getSerializer(TreeContext sctx, List<Action> actions, MappingStore mappings) throws IOException;
    }
    public static class Options extends AbstractDiffClient.Options {
	protected OutputFormat format;
	protected String output;

	@Override
	public Option[] values() {
	    return Option.Context.addValue(super.values(),
		    new Option("-f", String.format("format: %s", Arrays.toString(OutputFormat.values())), 1) {
			@Override
			protected void process(String name, String[] args) {
			    try {
				format = OutputFormat.valueOf(args[0].toUpperCase());
			    } catch (IllegalArgumentException e) {
				System.err.printf("No such format '%s', available formats are: %s\n",
					args[0].toUpperCase(), Arrays.toString(OutputFormat.values()));
				System.exit(-1);
			    }
			}
		    },
		    new Option("-o", "output file", 1) {
			@Override
			protected void process(String name, String[] args) {
			    output = args[0];
			}
		    }
	    );
	}
    }

    @Override
    protected Options newOptions() {
	return new Options();
    }

    @Override
    public void run() {
	Matcher m = matchTrees();
	ActionGenerator g = new ActionGenerator(getSrcTreeContext().getRoot(),
		getDstTreeContext().getRoot(), m.getMappings());
	g.generate();
	List<Action> actions = g.getActions();
	try {
	    ActionsIoUtils.ActionSerializer serializer = 
		opts.format.getSerializer(
		    getSrcTreeContext(), actions, m.getMappings());
	    serializer.writeTo(System.out);
	} catch (Exception e) {
	    e.printStackTrace();
	}
    }
}

