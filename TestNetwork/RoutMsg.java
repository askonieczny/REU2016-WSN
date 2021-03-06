/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'RoutMsg'
 * message type.
 */

public class RoutMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 8;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 1;

    /** Create a new RoutMsg of size 8. */
    public RoutMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new RoutMsg of the given data_length. */
    public RoutMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg with the given data_length
     * and base offset.
     */
    public RoutMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg using the given byte array
     * as backing store.
     */
    public RoutMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public RoutMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public RoutMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg embedded in the given message
     * at the given base offset.
     */
    public RoutMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoutMsg embedded in the given message
     * at the given base offset and length.
     */
    public RoutMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <RoutMsg> \n";
      try {
        s += "  [routing=0x"+Long.toHexString(get_routing())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [overlap=0x"+Long.toHexString(get_overlap())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [numNodes=0x"+Long.toHexString(get_numNodes())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: routing
    //   Field type: int, signed
    //   Offset (bits): 0
    //   Size (bits): 32
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'routing' is signed (true).
     */
    public static boolean isSigned_routing() {
        return true;
    }

    /**
     * Return whether the field 'routing' is an array (false).
     */
    public static boolean isArray_routing() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'routing'
     */
    public static int offset_routing() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'routing'
     */
    public static int offsetBits_routing() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'routing'
     */
    public int get_routing() {
        return (int)getSIntBEElement(offsetBits_routing(), 32);
    }

    /**
     * Set the value of the field 'routing'
     */
    public void set_routing(int value) {
        setSIntBEElement(offsetBits_routing(), 32, value);
    }

    /**
     * Return the size, in bytes, of the field 'routing'
     */
    public static int size_routing() {
        return (32 / 8);
    }

    /**
     * Return the size, in bits, of the field 'routing'
     */
    public static int sizeBits_routing() {
        return 32;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: overlap
    //   Field type: short, signed
    //   Offset (bits): 32
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'overlap' is signed (true).
     */
    public static boolean isSigned_overlap() {
        return true;
    }

    /**
     * Return whether the field 'overlap' is an array (false).
     */
    public static boolean isArray_overlap() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'overlap'
     */
    public static int offset_overlap() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'overlap'
     */
    public static int offsetBits_overlap() {
        return 32;
    }

    /**
     * Return the value (as a short) of the field 'overlap'
     */
    public short get_overlap() {
        return (short)getSIntBEElement(offsetBits_overlap(), 16);
    }

    /**
     * Set the value of the field 'overlap'
     */
    public void set_overlap(short value) {
        setSIntBEElement(offsetBits_overlap(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'overlap'
     */
    public static int size_overlap() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'overlap'
     */
    public static int sizeBits_overlap() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numNodes
    //   Field type: short, signed
    //   Offset (bits): 48
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numNodes' is signed (true).
     */
    public static boolean isSigned_numNodes() {
        return true;
    }

    /**
     * Return whether the field 'numNodes' is an array (false).
     */
    public static boolean isArray_numNodes() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numNodes'
     */
    public static int offset_numNodes() {
        return (48 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numNodes'
     */
    public static int offsetBits_numNodes() {
        return 48;
    }

    /**
     * Return the value (as a short) of the field 'numNodes'
     */
    public short get_numNodes() {
        return (short)getSIntBEElement(offsetBits_numNodes(), 16);
    }

    /**
     * Set the value of the field 'numNodes'
     */
    public void set_numNodes(short value) {
        setSIntBEElement(offsetBits_numNodes(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numNodes'
     */
    public static int size_numNodes() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numNodes'
     */
    public static int sizeBits_numNodes() {
        return 16;
    }

}
