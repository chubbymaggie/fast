// automatically generated by the FlatBuffers compiler, do not modify

package _fast._Bugs;

import java.nio.*;
import java.lang.*;
import java.util.*;
import com.google.flatbuffers.*;

@SuppressWarnings("unused")
public final class Bug extends Table {
  public static Bug getRootAsBug(ByteBuffer _bb) { return getRootAsBug(_bb, new Bug()); }
  public static Bug getRootAsBug(ByteBuffer _bb, Bug obj) { _bb.order(ByteOrder.LITTLE_ENDIAN); return (obj.__assign(_bb.getInt(_bb.position()) + _bb.position(), _bb)); }
  public void __init(int _i, ByteBuffer _bb) { bb_pos = _i; bb = _bb; }
  public Bug __assign(int _i, ByteBuffer _bb) { __init(_i, _bb); return this; }

  public String id() { int o = __offset(4); return o != 0 ? __string(o + bb_pos) : null; }
  public ByteBuffer idAsByteBuffer() { return __vector_as_bytebuffer(4, 1); }
  public String opendate() { int o = __offset(6); return o != 0 ? __string(o + bb_pos) : null; }
  public ByteBuffer opendateAsByteBuffer() { return __vector_as_bytebuffer(6, 1); }
  public String fixdate() { int o = __offset(8); return o != 0 ? __string(o + bb_pos) : null; }
  public ByteBuffer fixdateAsByteBuffer() { return __vector_as_bytebuffer(8, 1); }
  public _fast._Bugs._Bug.Info buginfo() { return buginfo(new _fast._Bugs._Bug.Info()); }
  public _fast._Bugs._Bug.Info buginfo(_fast._Bugs._Bug.Info obj) { int o = __offset(10); return o != 0 ? obj.__assign(__indirect(o + bb_pos), bb) : null; }
  public String fixedFile(int j) { int o = __offset(12); return o != 0 ? __string(__vector(o) + j * 4) : null; }
  public int fixedFileLength() { int o = __offset(12); return o != 0 ? __vector_len(o) : 0; }

  public static int createBug(FlatBufferBuilder builder,
      int idOffset,
      int opendateOffset,
      int fixdateOffset,
      int buginfoOffset,
      int fixed_fileOffset) {
    builder.startObject(5);
    Bug.addFixedFile(builder, fixed_fileOffset);
    Bug.addBuginfo(builder, buginfoOffset);
    Bug.addFixdate(builder, fixdateOffset);
    Bug.addOpendate(builder, opendateOffset);
    Bug.addId(builder, idOffset);
    return Bug.endBug(builder);
  }

  public static void startBug(FlatBufferBuilder builder) { builder.startObject(5); }
  public static void addId(FlatBufferBuilder builder, int idOffset) { builder.addOffset(0, idOffset, 0); }
  public static void addOpendate(FlatBufferBuilder builder, int opendateOffset) { builder.addOffset(1, opendateOffset, 0); }
  public static void addFixdate(FlatBufferBuilder builder, int fixdateOffset) { builder.addOffset(2, fixdateOffset, 0); }
  public static void addBuginfo(FlatBufferBuilder builder, int buginfoOffset) { builder.addOffset(3, buginfoOffset, 0); }
  public static void addFixedFile(FlatBufferBuilder builder, int fixedFileOffset) { builder.addOffset(4, fixedFileOffset, 0); }
  public static int createFixedFileVector(FlatBufferBuilder builder, int[] data) { builder.startVector(4, data.length, 4); for (int i = data.length - 1; i >= 0; i--) builder.addOffset(data[i]); return builder.endVector(); }
  public static void startFixedFileVector(FlatBufferBuilder builder, int numElems) { builder.startVector(4, numElems, 4); }
  public static int endBug(FlatBufferBuilder builder) {
    int o = builder.endObject();
    return o;
  }
}
