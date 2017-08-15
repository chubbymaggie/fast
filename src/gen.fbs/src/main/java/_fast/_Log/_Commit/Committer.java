// automatically generated by the FlatBuffers compiler, do not modify

package _fast._Log._Commit;

import java.nio.*;
import java.lang.*;
import java.util.*;
import com.google.flatbuffers.*;

@SuppressWarnings("unused")
public final class Committer extends Table {
  public static Committer getRootAsCommitter(ByteBuffer _bb) { return getRootAsCommitter(_bb, new Committer()); }
  public static Committer getRootAsCommitter(ByteBuffer _bb, Committer obj) { _bb.order(ByteOrder.LITTLE_ENDIAN); return (obj.__assign(_bb.getInt(_bb.position()) + _bb.position(), _bb)); }
  public void __init(int _i, ByteBuffer _bb) { bb_pos = _i; bb = _bb; }
  public Committer __assign(int _i, ByteBuffer _bb) { __init(_i, _bb); return this; }

  public int committerId() { int o = __offset(4); return o != 0 ? bb.getInt(o + bb_pos) : 0; }
  public String commitDate() { int o = __offset(6); return o != 0 ? __string(o + bb_pos) : null; }
  public ByteBuffer commitDateAsByteBuffer() { return __vector_as_bytebuffer(6, 1); }

  public static int createCommitter(FlatBufferBuilder builder,
      int committer_id,
      int commit_dateOffset) {
    builder.startObject(2);
    Committer.addCommitDate(builder, commit_dateOffset);
    Committer.addCommitterId(builder, committer_id);
    return Committer.endCommitter(builder);
  }

  public static void startCommitter(FlatBufferBuilder builder) { builder.startObject(2); }
  public static void addCommitterId(FlatBufferBuilder builder, int committerId) { builder.addInt(0, committerId, 0); }
  public static void addCommitDate(FlatBufferBuilder builder, int commitDateOffset) { builder.addOffset(1, commitDateOffset, 0); }
  public static int endCommitter(FlatBufferBuilder builder) {
    int o = builder.endObject();
    return o;
  }
}
