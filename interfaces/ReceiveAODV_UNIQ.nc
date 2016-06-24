

interface ReceiveAODV_UNIQ {

  /**
   * Receive a packet buffer, returning a buffer for the signaling
   * component to use for the next reception. The return value
   * can be the same as <tt>msg</tt>, as long as the handling
   * component copies out the data it needs.
   *
   * <b>Note</b> that misuse of this interface is one of the most
   * common bugs in TinyOS code. For example, if a component both calls a
   * send on the passed message and returns it, then it is possible
   * the buffer will be reused before the send occurs, overwriting
   * the component's data. This would cause the mote to possibly
   * instead send a packet it most recently received.
   *
   * @param  'message_t* ONE msg'        the receied packet
   * @param  'void* COUNT(len) payload'  a pointer to the packet's payload
   * @param  len      the length of the data region pointed to by payload
   * @return 'message_t* ONE'              a packet buffer for the stack to use for the next
   *                  received packet.
   */
  event message_t* receive(message_t* msg, void* payload, uint8_t len);
  
}