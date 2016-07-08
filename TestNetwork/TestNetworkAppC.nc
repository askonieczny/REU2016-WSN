/**
 * TestNetworkC exercises the basic networking layers, collection and
 * dissemination. The application samples DemoSensorC at a basic rate
 * and sends packets up a collection tree. The rate is configurable
 * through dissemination.
 *
 * See TEP118: Dissemination, TEP 119: Collection, and TEP 123: The
 * Collection Tree Protocol for details.
 *
 * @author Philip Levis
 * @version $Revision: 1.7 $ $Date: 2009-09-16 00:51:50 $
 */
#include "TestNetwork.h"
#include "Ctp.h"

configuration TestNetworkAppC {}

implementation {
  components TestNetworkC, MainC, LedsC, AODV, ActiveMessageC;
  components DisseminationC;
  components new DisseminatorC(uint32_t, SAMPLE_RATE_KEY) as Object32C;
  components CollectionC as Collector;
  components new CollectionSenderC(CL_TEST);
  components new TimerMilliC();
  components new DemoSensorC();
  components new SerialAMSenderC(CL_TEST);
  components new AMReceiverC(AM_ROUT_MSG) as RoutReceiver;
  components new AMReceiverC(AM_FLOOD_MSG) as FloodReceiver;
  components new AMReceiverC(AM_OVERLAP_PING_REQ) as PingReqReceiver;
  components new AMReceiverC(AM_OVERLAP_PING_REP) as PingRepReceiver;
  components new AMSenderC(AM_FLOOD_MSG) as FloodSender;
  components new AMSenderC(AM_OVERLAP_PING_REQ) as PingReqSender;
  components new AMSenderC(AM_OVERLAP_PING_REP) as PingRepSender;
  components SerialActiveMessageC;
#ifndef NO_DEBUG 
  components new SerialAMSenderC(AM_COLLECTION_DEBUG) as UARTSender;
  components UARTDebugSenderP as DebugSender;
#endif
  components RandomC;
  components new QueueC(message_t*, 12);
  components new PoolC(message_t, 12);

  TestNetworkC.Boot -> MainC.Boot;
  TestNetworkC.RadioControl -> ActiveMessageC;
  TestNetworkC.SerialControl -> SerialActiveMessageC;
  TestNetworkC.RoutingControl -> Collector;
  TestNetworkC.DisseminationControl -> DisseminationC;
  TestNetworkC.Leds -> LedsC;
  TestNetworkC.Timer -> TimerMilliC;
  TestNetworkC.DisseminationPeriod -> Object32C;
  TestNetworkC.Send -> CollectionSenderC;
  TestNetworkC.ReadSensor -> DemoSensorC;
  TestNetworkC.RootControl -> Collector;
  TestNetworkC.ReceiveCTP -> Collector.Receive[CL_TEST];
  TestNetworkC.UARTSend -> SerialAMSenderC.AMSend;
  TestNetworkC.CollectionPacket -> Collector;
  TestNetworkC.CtpInfo -> Collector;
  TestNetworkC.CtpCongestion -> Collector;
  TestNetworkC.Random -> RandomC;
  TestNetworkC.Pool -> PoolC;
  TestNetworkC.Queue -> QueueC;
  TestNetworkC.RadioPacket -> ActiveMessageC;

  //AODV components
  TestNetworkC.ReceiveAODV -> AODV.Receive[1];
  TestNetworkC.AMAODVSend -> AODV.AMSend[1];
  TestNetworkC.SplitControlAODV -> AODV.SplitControl;
  TestNetworkC.MilliTimer -> TimerMilliC;
  TestNetworkC.Leds -> LedsC;

  //Routing protocol receive component
  TestNetworkC.ReceiveRout -> RoutReceiver;

  //Simple flooding components
  TestNetworkC.ReceiveFlood -> FloodReceiver;
  TestNetworkC.Packet -> FloodSender;
  TestNetworkC.AMFloodSend -> FloodSender;
  TestNetworkC.SplitControlFlood -> ActiveMessageC;

  //Overlapping components
  TestNetworkC.PingReqSend -> PingReqSender;
  TestNetworkC.PingRepSend -> PingRepSender;
  TestNetworkC.ReceivePingReq -> PingReqReceiver;
  TestNetworkC.ReceivePingRep -> PingRepReceiver;
  TestNetworkC.PingReqPacket -> PingReqSender;
  TestNetworkC.PingRepPacket -> PingRepSender;


#ifndef NO_DEBUG
  components new PoolC(message_t, 10) as DebugMessagePool;
  components new QueueC(message_t*, 10) as DebugSendQueue;
  DebugSender.Boot -> MainC;
  DebugSender.UARTSend -> UARTSender;
  DebugSender.MessagePool -> DebugMessagePool;
  DebugSender.SendQueue -> DebugSendQueue;
  Collector.CollectionDebug -> DebugSender;
  TestNetworkC.CollectionDebug -> DebugSender;
#endif
  TestNetworkC.AMPacket -> ActiveMessageC;
}
