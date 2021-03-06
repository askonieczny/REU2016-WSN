/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'UniversalMsg'
 * message type.
 */

public class UniversalMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 18;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 1;

    /** Create a new UniversalMsg of size 18. */
    public UniversalMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new UniversalMsg of the given data_length. */
    public UniversalMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg with the given data_length
     * and base offset.
     */
    public UniversalMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg using the given byte array
     * as backing store.
     */
    public UniversalMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public UniversalMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public UniversalMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg embedded in the given message
     * at the given base offset.
     */
    public UniversalMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new UniversalMsg embedded in the given message
     * at the given base offset and length.
     */
    public UniversalMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <UniversalMsg> \n";
      try {
        s += "  [source=0x"+Long.toHexString(get_source())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [seqno=0x"+Long.toHexString(get_seqno())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [parent=0x"+Long.toHexString(get_parent())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [metric=0x"+Long.toHexString(get_metric())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [data=0x"+Long.toHexString(get_data())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [hopcount=0x"+Long.toHexString(get_hopcount())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [sendCount=0x"+Long.toHexString(get_sendCount())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [sendSuccessCount=0x"+Long.toHexString(get_sendSuccessCount())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [dest=0x"+Long.toHexString(get_dest())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [app=0x"+Long.toHexString(get_app())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: source
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'source' is signed (false).
     */
    public static boolean isSigned_source() {
        return false;
    }

    /**
     * Return whether the field 'source' is an array (false).
     */
    public static boolean isArray_source() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'source'
     */
    public static int offset_source() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'source'
     */
    public static int offsetBits_source() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'source'
     */
    public int get_source() {
        return (int)getUIntBEElement(offsetBits_source(), 16);
    }

    /**
     * Set the value of the field 'source'
     */
    public void set_source(int value) {
        setUIntBEElement(offsetBits_source(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'source'
     */
    public static int size_source() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'source'
     */
    public static int sizeBits_source() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: seqno
    //   Field type: int, unsigned
    //   Offset (bits): 16
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'seqno' is signed (false).
     */
    public static boolean isSigned_seqno() {
        return false;
    }

    /**
     * Return whether the field 'seqno' is an array (false).
     */
    public static boolean isArray_seqno() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'seqno'
     */
    public static int offset_seqno() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'seqno'
     */
    public static int offsetBits_seqno() {
        return 16;
    }

    /**
     * Return the value (as a int) of the field 'seqno'
     */
    public int get_seqno() {
        return (int)getUIntBEElement(offsetBits_seqno(), 16);
    }

    /**
     * Set the value of the field 'seqno'
     */
    public void set_seqno(int value) {
        setUIntBEElement(offsetBits_seqno(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'seqno'
     */
    public static int size_seqno() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'seqno'
     */
    public static int sizeBits_seqno() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: parent
    //   Field type: int, unsigned
    //   Offset (bits): 32
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'parent' is signed (false).
     */
    public static boolean isSigned_parent() {
        return false;
    }

    /**
     * Return whether the field 'parent' is an array (false).
     */
    public static boolean isArray_parent() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'parent'
     */
    public static int offset_parent() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'parent'
     */
    public static int offsetBits_parent() {
        return 32;
    }

    /**
     * Return the value (as a int) of the field 'parent'
     */
    public int get_parent() {
        return (int)getUIntBEElement(offsetBits_parent(), 16);
    }

    /**
     * Set the value of the field 'parent'
     */
    public void set_parent(int value) {
        setUIntBEElement(offsetBits_parent(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'parent'
     */
    public static int size_parent() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'parent'
     */
    public static int sizeBits_parent() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: metric
    //   Field type: int, unsigned
    //   Offset (bits): 48
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'metric' is signed (false).
     */
    public static boolean isSigned_metric() {
        return false;
    }

    /**
     * Return whether the field 'metric' is an array (false).
     */
    public static boolean isArray_metric() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'metric'
     */
    public static int offset_metric() {
        return (48 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'metric'
     */
    public static int offsetBits_metric() {
        return 48;
    }

    /**
     * Return the value (as a int) of the field 'metric'
     */
    public int get_metric() {
        return (int)getUIntBEElement(offsetBits_metric(), 16);
    }

    /**
     * Set the value of the field 'metric'
     */
    public void set_metric(int value) {
        setUIntBEElement(offsetBits_metric(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'metric'
     */
    public static int size_metric() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'metric'
     */
    public static int sizeBits_metric() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: data
    //   Field type: int, unsigned
    //   Offset (bits): 64
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'data' is signed (false).
     */
    public static boolean isSigned_data() {
        return false;
    }

    /**
     * Return whether the field 'data' is an array (false).
     */
    public static boolean isArray_data() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'data'
     */
    public static int offset_data() {
        return (64 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'data'
     */
    public static int offsetBits_data() {
        return 64;
    }

    /**
     * Return the value (as a int) of the field 'data'
     */
    public int get_data() {
        return (int)getUIntBEElement(offsetBits_data(), 16);
    }

    /**
     * Set the value of the field 'data'
     */
    public void set_data(int value) {
        setUIntBEElement(offsetBits_data(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'data'
     */
    public static int size_data() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'data'
     */
    public static int sizeBits_data() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: hopcount
    //   Field type: short, unsigned
    //   Offset (bits): 80
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'hopcount' is signed (false).
     */
    public static boolean isSigned_hopcount() {
        return false;
    }

    /**
     * Return whether the field 'hopcount' is an array (false).
     */
    public static boolean isArray_hopcount() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'hopcount'
     */
    public static int offset_hopcount() {
        return (80 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'hopcount'
     */
    public static int offsetBits_hopcount() {
        return 80;
    }

    /**
     * Return the value (as a short) of the field 'hopcount'
     */
    public short get_hopcount() {
        return (short)getUIntBEElement(offsetBits_hopcount(), 8);
    }

    /**
     * Set the value of the field 'hopcount'
     */
    public void set_hopcount(short value) {
        setUIntBEElement(offsetBits_hopcount(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'hopcount'
     */
    public static int size_hopcount() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'hopcount'
     */
    public static int sizeBits_hopcount() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: sendCount
    //   Field type: int, unsigned
    //   Offset (bits): 88
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'sendCount' is signed (false).
     */
    public static boolean isSigned_sendCount() {
        return false;
    }

    /**
     * Return whether the field 'sendCount' is an array (false).
     */
    public static boolean isArray_sendCount() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'sendCount'
     */
    public static int offset_sendCount() {
        return (88 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'sendCount'
     */
    public static int offsetBits_sendCount() {
        return 88;
    }

    /**
     * Return the value (as a int) of the field 'sendCount'
     */
    public int get_sendCount() {
        return (int)getUIntBEElement(offsetBits_sendCount(), 16);
    }

    /**
     * Set the value of the field 'sendCount'
     */
    public void set_sendCount(int value) {
        setUIntBEElement(offsetBits_sendCount(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'sendCount'
     */
    public static int size_sendCount() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'sendCount'
     */
    public static int sizeBits_sendCount() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: sendSuccessCount
    //   Field type: int, unsigned
    //   Offset (bits): 104
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'sendSuccessCount' is signed (false).
     */
    public static boolean isSigned_sendSuccessCount() {
        return false;
    }

    /**
     * Return whether the field 'sendSuccessCount' is an array (false).
     */
    public static boolean isArray_sendSuccessCount() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'sendSuccessCount'
     */
    public static int offset_sendSuccessCount() {
        return (104 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'sendSuccessCount'
     */
    public static int offsetBits_sendSuccessCount() {
        return 104;
    }

    /**
     * Return the value (as a int) of the field 'sendSuccessCount'
     */
    public int get_sendSuccessCount() {
        return (int)getUIntBEElement(offsetBits_sendSuccessCount(), 16);
    }

    /**
     * Set the value of the field 'sendSuccessCount'
     */
    public void set_sendSuccessCount(int value) {
        setUIntBEElement(offsetBits_sendSuccessCount(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'sendSuccessCount'
     */
    public static int size_sendSuccessCount() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'sendSuccessCount'
     */
    public static int sizeBits_sendSuccessCount() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: dest
    //   Field type: int, unsigned
    //   Offset (bits): 120
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'dest' is signed (false).
     */
    public static boolean isSigned_dest() {
        return false;
    }

    /**
     * Return whether the field 'dest' is an array (false).
     */
    public static boolean isArray_dest() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'dest'
     */
    public static int offset_dest() {
        return (120 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'dest'
     */
    public static int offsetBits_dest() {
        return 120;
    }

    /**
     * Return the value (as a int) of the field 'dest'
     */
    public int get_dest() {
        return (int)getUIntBEElement(offsetBits_dest(), 16);
    }

    /**
     * Set the value of the field 'dest'
     */
    public void set_dest(int value) {
        setUIntBEElement(offsetBits_dest(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'dest'
     */
    public static int size_dest() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'dest'
     */
    public static int sizeBits_dest() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: app
    //   Field type: short, unsigned
    //   Offset (bits): 136
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'app' is signed (false).
     */
    public static boolean isSigned_app() {
        return false;
    }

    /**
     * Return whether the field 'app' is an array (false).
     */
    public static boolean isArray_app() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'app'
     */
    public static int offset_app() {
        return (136 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'app'
     */
    public static int offsetBits_app() {
        return 136;
    }

    /**
     * Return the value (as a short) of the field 'app'
     */
    public short get_app() {
        return (short)getUIntBEElement(offsetBits_app(), 8);
    }

    /**
     * Set the value of the field 'app'
     */
    public void set_app(short value) {
        setUIntBEElement(offsetBits_app(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'app'
     */
    public static int size_app() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'app'
     */
    public static int sizeBits_app() {
        return 8;
    }

}
