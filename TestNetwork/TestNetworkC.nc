/**
 * TestNetworkC exercises the basic networking layers, collection and
 * dissemination. The application samples DemoSensorC at a basic rate
 * and sends packets up a collection tree. The rate is configurable
 * through dissemination. The default send rate is every 10s.
 *
 * See TEP118: Dissemination and TEP 119: Collection for details.
 *
 * @author Philip Levis
 * @version $Revision: 1.11 $ $Date: 2010-01-14 21:53:58 $
 */

#include <Timer.h>
#include "TestNetwork.h"
#include "CtpDebugMsg.h"
#include <stdlib.h>

module TestNetworkC {
  provides interface GetProt;
  uses interface Boot;
  uses interface Receive as ReceiveAODV;
  uses interface Receive as ReceiveCTP;
  uses interface Receive as ReceiveFlood;
  uses interface Receive as ReceiveRout;
  uses interface SplitControl as SplitControlAODV;
  uses interface SplitControl as RadioControl;
  uses interface SplitControl as SerialControl;
  uses interface SplitControl as SplitControlFlood;
  uses interface StdControl as RoutingControl;
  uses interface StdControl as DisseminationControl;
  uses interface DisseminationValue<uint32_t> as DisseminationPeriod;
  uses interface Send;
  uses interface Leds;
  uses interface Read<uint16_t> as ReadSensor;
  uses interface Timer<TMilli>;
  uses interface Timer<TMilli> as MilliTimer;
  uses interface RootControl;
  uses interface AMSend as AMAODVSend;
  uses interface AMSend as AMFloodSend;
  uses interface AMSend as UARTSend;
  uses interface CollectionPacket;
  uses interface CtpInfo;
  uses interface CtpCongestion;
  uses interface Random;
  uses interface Queue<message_t*>;
  uses interface Pool<message_t>;
  uses interface CollectionDebug;
  uses interface AMPacket;
  uses interface Packet;
  uses interface Packet as RadioPacket;
}


implementation {

  /*
    global variable that determines whether to use CTP (if 1)
    or AODV (if 2)
  */
  nx_int32_t prot; //protocol not initially specified

    //CTP variables
    task void uartEchoTask();
    message_t packet;
    message_t uartpacket;
    message_t* recvPtr = &uartpacket;
    uint8_t msglen;
    bool sendBusy = FALSE;
    bool uartbusy = FALSE;
    bool initialBoot = TRUE;
    bool firstTimer = TRUE;
    uint16_t seqno;
    float temp;
    float wind;
    float hum;
    float num = 0;
    enum {
      SEND_INTERVAL = 8192
    };


  //AODV variables
  message_t pkt;
  message_t* p_pkt;

  uint16_t src = 10; //source node of AODV send
  uint16_t dest = 19; //destination node of AODV send

  uint8_t prevSeq = 0;
  uint8_t firstMsg = 0;

  rout_msg_t* r;

  //Simple flooding variables
  uint16_t sfSink = 20;
  float temp_f = 0;
  float wind_f = 0;
  float hum_f =0;
  float num_f = 0;
  uint16_t tmpSources[10];
  uint16_t msgSources[10];
  message_t floodPkt;
  bool match;
  uint16_t i;
  uint16_t j;

  event void ReadSensor.readDone(error_t err, uint16_t val) { }

  event void Boot.booted() {
    call SplitControlAODV.start();
    call SplitControlFlood.start();
    call SerialControl.start();
  }

  event void SerialControl.startDone(error_t err) {
    call RadioControl.start();
  }
  event void RadioControl.startDone(error_t err) {
    if (err != SUCCESS) {
      call RadioControl.start();
    }
    else {
      initialBoot = TRUE;
    }
  }

  event void SplitControlAODV.startDone(error_t err) {
    if (err == SUCCESS) {
    } else {
      call SplitControlAODV.start();
      }
  }

  event void SplitControlFlood.startDone(error_t err) {
    if (err == SUCCESS) {
    } else {
      call SplitControlFlood.start();
      }
  }
  event void SplitControlAODV.stopDone(error_t err) {}
  event void SplitControlFlood.stopDone(error_t err) {}
  event void RadioControl.stopDone(error_t err) {}
  event void SerialControl.stopDone(error_t err) {}

  void failedSend() {
    dbg("App", "%s: Send failed.\n", __FUNCTION__);
    call CollectionDebug.logEvent(NET_C_DBG_1);
  }

  void sendMessage() {
    TestNetworkMsg* msg = (TestNetworkMsg*)call Send.getPayload(&packet, sizeof(TestNetworkMsg));
    uint16_t metric;
    am_addr_t parent = 0;

    call CtpInfo.getParent(&parent);
    call CtpInfo.getEtx(&metric);

      msg->source = TOS_NODE_ID;
      msg->seqno = seqno;
      msg->temp = rand() % 40 + 40;
      msg ->hum = rand() % 20 + 70;
      msg ->wind = rand() % 20;
      msg->parent = parent;
      msg->hopcount = 0;
      msg->metric = metric;

    if (call Send.send(&packet, sizeof(TestNetworkMsg)) != SUCCESS) {
      failedSend();
      call Leds.led0On();
      dbg("TestNetworkC", "%s: Transmission failed.\n", __FUNCTION__);
    }
    else {
      sendBusy = TRUE;
      seqno++;
      dbg("TestNetworkC", "%s: Transmission succeeded.\n", __FUNCTION__);
    }
  }

  //This timer used exclusively for CTP nodes
  event void Timer.fired() {
    if(prot == 1) {
      uint32_t nextInt;

      nextInt = call Random.rand32() % SEND_INTERVAL;
      nextInt += SEND_INTERVAL >> 1;
      call Timer.startOneShot(nextInt);
      if (!sendBusy) {
        if(prot == 1) {
          sendMessage();
        }
      }
    }
  }

  //This timer used for AODV and simple flooding nodes
  event void MilliTimer.fired() {
    if(prot == 2) { //if protocol is AODV
      dbg("APPS", "%s\t APPS: MilliTimer.fired()\n", sim_time_string());
      call Leds.led0Toggle();
      call AMAODVSend.send(dest, p_pkt, sizeof(pkt));
    }
    else if(prot == 3) { //if protocol is Simple flooding
      flood_msg_t* floodMsg = (flood_msg_t*)call Packet.getPayload(&floodPkt, sizeof(flood_msg_t));
      floodMsg -> temp = rand() % 40 + 40;
      floodMsg -> hum = rand() % 20 + 70;
      floodMsg -> wind = rand() % 20;
      i = 0;
      while(i < 10) {
        floodMsg -> sources[i] = 0;
        i++;
      }
      call AMFloodSend.send(AM_BROADCAST_ADDR, &floodPkt, sizeof(flood_msg_t));
    }
  }


  event void Send.sendDone(message_t* m, error_t err) {
    if (err != SUCCESS) {
      call Leds.led0On();
    }
    sendBusy = FALSE;
    dbg("TestNetworkC", "CTP Send completed.\n");
  }

  event void AMAODVSend.sendDone(message_t* bufPtr, error_t error) {
    if(prot == 2) {
      dbg("APPS", "APPS: AODV sendDone!!\n");
    }
  }

  event void AMFloodSend.sendDone(message_t* bufPtr, error_t error) {
    if(prot == 3) {
      dbg("TestNetworkC", "\t Flooding: send done\n");
    }
  }

  event void DisseminationPeriod.changed() {
    const uint32_t* newVal = call DisseminationPeriod.get();
    call Timer.stop();
    call Timer.startPeriodic(*newVal);
  }

  //This event receives routing protocol specification (CTP = 1, AODV = 2, Simple flooding = 3)
  event message_t* ReceiveRout.receive(message_t* msg, void* payload, uint8_t len) {
    r = (rout_msg_t*)payload;
    prot = r -> routing;
    dbg("TestNetworkC", "Routing protocol for this node (%d) is %d\n", TOS_NODE_ID, prot);

    //Set up CTP routing stuff
    if(prot == 1 && initialBoot == TRUE) {
      call DisseminationControl.start();
      call RoutingControl.start();
      if (TOS_NODE_ID % 500 == 0) {
       call RootControl.setRoot();
      }
      seqno = 0;
        call Timer.startOneShot(call Random.rand16() & 0x1ff);
    }

    //Set up AODV routing stuff
    if(prot == 2 && initialBoot == TRUE) {
      dbg("APPS", "%s\t APPS: startDone\n", sim_time_string());
      p_pkt = &pkt;
      if( TOS_NODE_ID == src ) {
        dbg("AODV", "Millitimer started on node %d because src is %d\n", TOS_NODE_ID, src);
        call MilliTimer.startPeriodic(1024);
        }
    }

    if(prot == 3 && initialBoot == TRUE) {
      dbg("APPS", "%s\t Flooding: startDone\n", sim_time_string());
      if( TOS_NODE_ID == sfSink) {
        call MilliTimer.startPeriodic(1000);
      }
    }
    return msg;
  }

  //Protocol receive events (different depending upon which protocol node is following)

  event message_t* ReceiveFlood.receive(message_t* msg, void* payload, uint8_t len) {
    flood_msg_t* f;
    flood_msg_t* floodMsgNew;
    if(prot == 3) { //if protocol is Flooding
      f = (flood_msg_t*)payload;
      i = 0;
      while(i < 10) {
        msgSources[i] = f -> sources[i];
        i++;
      }

      //see if node should ignore this message (if already broadcast)
      i = 0;
      match = FALSE;
      while (i < 10) {
        if(msgSources[i] == TOS_NODE_ID) {
          match = TRUE;
          break;
        }
        i++;
      }

      //add ID to source array, send to next nodes if not already received
      if(match == FALSE) {
        dbg("TestNetworkC", "\t Flooding: message received, \n");
        //if(TOS_NODE_ID == sfSink){

        temp_f += f -> temp;
        hum_f += f -> hum;
        wind_f += f -> wind;
        num_f ++;
        dbg("TestNetworkC", "\t Flooding: message received, temp is %.3f\n", temp_f/num_f);
        dbg("TestNetworkC", "\t Flooding: message received, hum is %.3f\n", hum_f/num_f);
        dbg("TestNetworkC", "\t Flooding: message received, wind is %.3f\n", wind_f/num_f);
        //}
        j = 0;
        while(TRUE && j < 10) {
          if(msgSources[j] == 0) {
            msgSources[j] = TOS_NODE_ID;
            break;
          }
          j++;
        }

        //send new message
        floodMsgNew = (flood_msg_t*)call Packet.getPayload(&floodPkt, sizeof(flood_msg_t));
        floodMsgNew -> temp = rand() % 40 + 40;
        floodMsgNew -> hum = rand() % 20 +70;
        floodMsgNew -> wind = rand() % 20;
        i = 0;
        while(i < 10) {
          floodMsgNew -> sources[i] = msgSources[i];
          i++;
        }
        call AMFloodSend.send(AM_BROADCAST_ADDR, &floodPkt, sizeof(flood_msg_t));
      } else {
        //dbg("TestNetworkC", "\t Flooding: message IGNORED\n");
      }
    }
    return msg;
  }


  event message_t* ReceiveAODV.receive(message_t* msg, void* payload, uint8_t len) {
    if(prot == 2) { //if protocol is AODV
     dbg("AODV", "%s\t Received!!!!\n", sim_time_string());
    }
    return msg;
  }

  event message_t* ReceiveCTP.receive(message_t* msg, void* payload, uint8_t len) {
    if(prot == 1) { //if protocol is CTP
    if(TOS_NODE_ID == 0){ //if current node is base station
    TestNetworkMsg* rcm = (TestNetworkMsg*) payload;
    temp += rcm -> temp;
    hum  += rcm -> hum;
    wind += rcm -> wind;
    num++;
    dbg("TestNetworkC", "CTP: Temp value is %.3f.\n", temp/num);
    dbg("TestNetworkC", "CTP: Wind value is %.3f.\n", wind/num);
    dbg("TestNetworkC", "CTP: Humidity value is %.3f.\n", hum/num);
    }
    dbg("TestNetworkC", "CTP Node received packet at %s from node %hhu.\n", sim_time_string(), call CollectionPacket.getOrigin(msg));
    call Leds.led1Toggle();

    if (call CollectionPacket.getOrigin(msg) == 1) {
      if (firstMsg == 1) {
      if (call CollectionPacket.getSequenceNumber(msg) - prevSeq > 1) {
        call Leds.led2On();
      }
        } else {
          firstMsg = 1;
        }
        prevSeq = call CollectionPacket.getSequenceNumber(msg);
    }

    if (!call Pool.empty() && call Queue.size() < call Queue.maxSize()) {
      message_t* tmp = call Pool.get();
      call Queue.enqueue(msg);
      if (!uartbusy) {
        post uartEchoTask();
      }
      return tmp;
    }
    return msg;

    }
 }

 task void uartEchoTask() {
    dbg("Traffic", "CTP node sending packet to UART.\n");
   if (call Queue.empty()) {
     return;
   }
   else if (!uartbusy) {
     message_t* msg = call Queue.dequeue();
     dbg("Traffic", "Sending packet to UART.\n");
     if (call UARTSend.send(0xffff, msg, call RadioPacket.payloadLength(msg)) == SUCCESS) {
       uartbusy = TRUE;
     }
     else {
      call CollectionDebug.logEventMsg(NET_C_DBG_2,
				       call CollectionPacket.getSequenceNumber(msg),
				       call CollectionPacket.getOrigin(msg),
				       call AMPacket.destination(msg));
     }
   }
 }

  event void UARTSend.sendDone(message_t *msg, error_t error) {
    dbg("Traffic", "UART send done.\n");
    uartbusy = FALSE;
    call Pool.put(msg);
    if (!call Queue.empty()) {
      post uartEchoTask();
    }
    else {
      //        call CtpCongestion.setClientCongested(FALSE);
    }
  }

  command nx_int32_t GetProt.get() {
    return prot;
  }

  /* Default implementations for CollectionDebug calls.
   * These allow CollectionDebug not to be wired to anything if debugging
   * is not desired. */


    default command error_t CollectionDebug.logEvent(uint8_t type) {
        return SUCCESS;
    }
    default command error_t CollectionDebug.logEventSimple(uint8_t type, uint16_t arg) {
        return SUCCESS;
    }
    default command error_t CollectionDebug.logEventDbg(uint8_t type, uint16_t arg1, uint16_t arg2, uint16_t arg3) {
        return SUCCESS;
    }
    default command error_t CollectionDebug.logEventMsg(uint8_t type, uint16_t msg, am_addr_t origin, am_addr_t node) {
        return SUCCESS;
    }
    default command error_t CollectionDebug.logEventRoute(uint8_t type, am_addr_t parent, uint8_t hopcount, uint16_t metric) {
        return SUCCESS;
    }

}
