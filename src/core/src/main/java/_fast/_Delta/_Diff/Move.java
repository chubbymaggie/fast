// automatically generated by the FlatBuffers compiler, do not modify

package _fast._Delta._Diff;

import java.nio.*;
import java.lang.*;
import java.util.*;
import com.google.flatbuffers.*;

@SuppressWarnings("unused")
public final class Move extends Table {
  public static Move getRootAsMove(ByteBuffer _bb) { return getRootAsMove(_bb, new Move()); }
  public static Move getRootAsMove(ByteBuffer _bb, Move obj) { _bb.order(ByteOrder.LITTLE_ENDIAN); return (obj.__assign(_bb.getInt(_bb.position()) + _bb.position(), _bb)); }
  public void __init(int _i, ByteBuffer _bb) { bb_pos = _i; bb = _bb; }
  public Move __assign(int _i, ByteBuffer _bb) { __init(_i, _bb); return this; }

  public int src() { int o = __offset(4); return o != 0 ? bb.getInt(o + bb_pos) : 0; }
  public int dst() { int o = __offset(6); return o != 0 ? bb.getInt(o + bb_pos) : 0; }
  public int position() { int o = __offset(8); return o != 0 ? bb.getInt(o + bb_pos) : 0; }

  public static int createMove(FlatBufferBuilder builder,
      int src,
      int dst,
      int position) {
    builder.startObject(3);
    Move.addPosition(builder, position);
    Move.addDst(builder, dst);
    Move.addSrc(builder, src);
    return Move.endMove(builder);
  }

  public static void startMove(FlatBufferBuilder builder) { builder.startObject(3); }
  public static void addSrc(FlatBufferBuilder builder, int src) { builder.addInt(0, src, 0); }
  public static void addDst(FlatBufferBuilder builder, int dst) { builder.addInt(1, dst, 0); }
  public static void addPosition(FlatBufferBuilder builder, int position) { builder.addInt(2, position, 0); }
  public static int endMove(FlatBufferBuilder builder) {
    int o = builder.endObject();
    return o;
  }
}

