//Based on the code for RadioCountToLeds

#include "Timer.h"
#include "SumNodes.h"

module SumNodesC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    interface SplitControl as AMControl;
    interface Packet;
  }
}
implementation {

  message_t packet;

  bool locked;
  bool pathPresent = FALSE;
  bool rcmReceived = FALSE;
  uint16_t valForNode = 0;
  nx_int32_t path;

  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      call MilliTimer.startPeriodic(250);
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }

  event void MilliTimer.fired() {
    //don't send message before ready
    if(locked || !pathPresent || !rcmReceived){
      return;
    }
    //send RCM message to next node if path is ready
    else{
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        if (rcm == NULL) {
          return;
        }
        rcm -> val = valForNode;
        if(path != -1){
          if (call AMSend.send(path, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
            dbg("SumNodesC", "Send radio count packet to %i\n", path);
            locked = TRUE;
          }
        }
    }
  }

  event message_t* Receive.receive(message_t* bufPtr,
				   void* payload, uint8_t len) {
    dbg("SumNodesC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t)) && len != sizeof(path_msg_t)) {
      return bufPtr;
    }
    else if(len == sizeof(path_msg_t)){
      //receive path information message, store in path variable
      path_msg_t* pm = (path_mst_t*) payload;
      path = pm -> path;
      dbg("SumNodesC", "Recieved instruction to send to %d\n", path);
      pathPresent = TRUE;
      return bufPtr;
    }
    else{
      //receive RadioCountMessage, update current sensing data
      radio_count_msg_t* rcm = (radio_count_msg_t*) payload;
      valForNode += rcm -> val;
      rcmReceived = TRUE;
      dbg("SumNodesC", "The current sum is: %i\n", valForNode);
      return bufPtr; //tabbed over in spRadioCountToLeds
    }

  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
}
