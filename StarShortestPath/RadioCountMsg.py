#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'RadioCountMsg'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 16

# The Active Message type associated with this message.
AM_TYPE = 6

class RadioCountMsg(tinyos.message.Message.Message):
    # Create a new RadioCountMsg of size 16.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=16):
        tinyos.message.Message.Message.__init__(self, data, addr, gid, base_offset, data_length)
        self.amTypeSet(AM_TYPE)
    
    # Get AM_TYPE
    def get_amType(cls):
        return AM_TYPE
    
    get_amType = classmethod(get_amType)
    
    #
    # Return a String representation of this message. Includes the
    # message type name and the non-indexed field values.
    #
    def __str__(self):
        s = "Message <RadioCountMsg> \n"
        try:
            s += "  [temp=0x%x]\n" % (self.get_temp())
        except:
            pass
        try:
            s += "  [hum=0x%x]\n" % (self.get_hum())
        except:
            pass
        try:
            s += "  [wind=0x%x]\n" % (self.get_wind())
        except:
            pass
        try:
            s += "  [num=0x%x]\n" % (self.get_num())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: temp
    #   Field type: long
    #   Offset (bits): 0
    #   Size (bits): 32
    #

    #
    # Return whether the field 'temp' is signed (False).
    #
    def isSigned_temp(self):
        return False
    
    #
    # Return whether the field 'temp' is an array (False).
    #
    def isArray_temp(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'temp'
    #
    def offset_temp(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'temp'
    #
    def offsetBits_temp(self):
        return 0
    
    #
    # Return the value (as a long) of the field 'temp'
    #
    def get_temp(self):
        return self.getUIntElement(self.offsetBits_temp(), 32, 1)
    
    #
    # Set the value of the field 'temp'
    #
    def set_temp(self, value):
        self.setUIntElement(self.offsetBits_temp(), 32, value, 1)
    
    #
    # Return the size, in bytes, of the field 'temp'
    #
    def size_temp(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'temp'
    #
    def sizeBits_temp(self):
        return 32
    
    #
    # Accessor methods for field: hum
    #   Field type: long
    #   Offset (bits): 32
    #   Size (bits): 32
    #

    #
    # Return whether the field 'hum' is signed (False).
    #
    def isSigned_hum(self):
        return False
    
    #
    # Return whether the field 'hum' is an array (False).
    #
    def isArray_hum(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'hum'
    #
    def offset_hum(self):
        return (32 / 8)
    
    #
    # Return the offset (in bits) of the field 'hum'
    #
    def offsetBits_hum(self):
        return 32
    
    #
    # Return the value (as a long) of the field 'hum'
    #
    def get_hum(self):
        return self.getUIntElement(self.offsetBits_hum(), 32, 1)
    
    #
    # Set the value of the field 'hum'
    #
    def set_hum(self, value):
        self.setUIntElement(self.offsetBits_hum(), 32, value, 1)
    
    #
    # Return the size, in bytes, of the field 'hum'
    #
    def size_hum(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'hum'
    #
    def sizeBits_hum(self):
        return 32
    
    #
    # Accessor methods for field: wind
    #   Field type: long
    #   Offset (bits): 64
    #   Size (bits): 32
    #

    #
    # Return whether the field 'wind' is signed (False).
    #
    def isSigned_wind(self):
        return False
    
    #
    # Return whether the field 'wind' is an array (False).
    #
    def isArray_wind(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'wind'
    #
    def offset_wind(self):
        return (64 / 8)
    
    #
    # Return the offset (in bits) of the field 'wind'
    #
    def offsetBits_wind(self):
        return 64
    
    #
    # Return the value (as a long) of the field 'wind'
    #
    def get_wind(self):
        return self.getUIntElement(self.offsetBits_wind(), 32, 1)
    
    #
    # Set the value of the field 'wind'
    #
    def set_wind(self, value):
        self.setUIntElement(self.offsetBits_wind(), 32, value, 1)
    
    #
    # Return the size, in bytes, of the field 'wind'
    #
    def size_wind(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'wind'
    #
    def sizeBits_wind(self):
        return 32
    
    #
    # Accessor methods for field: num
    #   Field type: long
    #   Offset (bits): 96
    #   Size (bits): 32
    #

    #
    # Return whether the field 'num' is signed (False).
    #
    def isSigned_num(self):
        return False
    
    #
    # Return whether the field 'num' is an array (False).
    #
    def isArray_num(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'num'
    #
    def offset_num(self):
        return (96 / 8)
    
    #
    # Return the offset (in bits) of the field 'num'
    #
    def offsetBits_num(self):
        return 96
    
    #
    # Return the value (as a long) of the field 'num'
    #
    def get_num(self):
        return self.getUIntElement(self.offsetBits_num(), 32, 1)
    
    #
    # Set the value of the field 'num'
    #
    def set_num(self, value):
        self.setUIntElement(self.offsetBits_num(), 32, value, 1)
    
    #
    # Return the size, in bytes, of the field 'num'
    #
    def size_num(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'num'
    #
    def sizeBits_num(self):
        return 32
    
