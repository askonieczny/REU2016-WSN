/**
 * OverlayNetworkC exercises the basic networking layers, collection and
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
#include "OverlayNetwork.h"
#include "Ctp.h"

configuration OverlayNetworkAppC {}

implementation {
  components OverlayNetworkC, MainC, LedsC, AODV, ActiveMessageC;
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
  components new AMReceiverC(AM_UNIVERSAL_MSG) as UniversalReceiver;
  components new AMSenderC(AM_FLOOD_MSG) as FloodSender;
  components new AMSenderC(AM_OVERLAP_PING_REQ) as PingReqSender;
  components new AMSenderC(AM_OVERLAP_PING_REP) as PingRepSender;
  components new AMSenderC(AM_UNIVERSAL_MSG) as UniversalSender;
  components SerialActiveMessageC;
#ifndef NO_DEBUG 
  components new SerialAMSenderC(AM_COLLECTION_DEBUG) as UARTSender;
  components UARTDebugSenderP as DebugSender;
#endif
  components RandomC;
  components new QueueC(message_t*, 12);
  components new PoolC(message_t, 12);

  OverlayNetworkC.Boot -> MainC.Boot;
  OverlayNetworkC.RadioControl -> ActiveMessageC;
  OverlayNetworkC.SerialControl -> SerialActiveMessageC;
  OverlayNetworkC.RoutingControl -> Collector;
  OverlayNetworkC.DisseminationControl -> DisseminationC;
  OverlayNetworkC.Leds -> LedsC;
  OverlayNetworkC.Timer -> TimerMilliC;
  OverlayNetworkC.DisseminationPeriod -> Object32C;
  OverlayNetworkC.Send -> CollectionSenderC;
  OverlayNetworkC.ReadSensor -> DemoSensorC;
  OverlayNetworkC.RootControl -> Collector;
  OverlayNetworkC.ReceiveCTP -> Collector.Receive[CL_TEST];
  OverlayNetworkC.UARTSend -> SerialAMSenderC.AMSend;
  OverlayNetworkC.CollectionPacket -> Collector;
  OverlayNetworkC.CtpInfo -> Collector;
  OverlayNetworkC.CtpCongestion -> Collector;
  OverlayNetworkC.Random -> RandomC;
  OverlayNetworkC.Pool -> PoolC;
  OverlayNetworkC.Queue -> QueueC;
  OverlayNetworkC.RadioPacket -> ActiveMessageC;

  //AODV components
  OverlayNetworkC.ReceiveAODV -> AODV.Receive[1];
  OverlayNetworkC.AMAODVSend -> AODV.AMSend[1];
  OverlayNetworkC.SplitControlAODV -> AODV.SplitControl;
  OverlayNetworkC.MilliTimer -> TimerMilliC;
  OverlayNetworkC.Leds -> LedsC;

  //Routing protocol receive component
  OverlayNetworkC.ReceiveRout -> RoutReceiver;

  //Simple flooding components
  OverlayNetworkC.ReceiveFlood -> FloodReceiver;
  OverlayNetworkC.Packet -> FloodSender;
  OverlayNetworkC.AMFloodSend -> FloodSender;
  OverlayNetworkC.SplitControlFlood -> ActiveMessageC;

  //Overlapping components
  OverlayNetworkC.PingReqSend -> PingReqSender;
  OverlayNetworkC.PingRepSend -> PingRepSender;
  OverlayNetworkC.ReceivePingReq -> PingReqReceiver;
  OverlayNetworkC.ReceivePingRep -> PingRepReceiver;
  OverlayNetworkC.PingReqPacket -> PingReqSender;
  OverlayNetworkC.PingRepPacket -> PingRepSender;

  //Universal msg components
  OverlayNetworkC.UniversalSend -> UniversalSender;
  OverlayNetworkC.UniversalPacket -> UniversalSender;
  OverlayNetworkC.ReceiveUniversal -> UniversalReceiver;


#ifndef NO_DEBUG
  components new PoolC(message_t, 10) as DebugMessagePool;
  components new QueueC(message_t*, 10) as DebugSendQueue;
  DebugSender.Boot -> MainC;
  DebugSender.UARTSend -> UARTSender;
  DebugSender.MessagePool -> DebugMessagePool;
  DebugSender.SendQueue -> DebugSendQueue;
  Collector.CollectionDebug -> DebugSender;
  OverlayNetworkC.CollectionDebug -> DebugSender;
#endif
  OverlayNetworkC.AMPacket -> ActiveMessageC;
}
