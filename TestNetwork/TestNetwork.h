#ifndef TEST_NETWORK_H
#define TEST_NETWORK_H

#include <AM.h>
#include "TestNetworkC.h"
#include "AODV.h"

typedef nx_struct TestNetworkMsg {
  nx_am_addr_t source;
  nx_uint16_t seqno;
  nx_am_addr_t parent;
  nx_uint16_t metric;
  nx_uint16_t temp;
  nx_uint16_t hum;
  nx_uint16_t wind;
  nx_uint8_t hopcount;
  nx_uint16_t sendCount;
  nx_uint16_t sendSuccessCount;
} TestNetworkMsg;

typedef nx_struct rout_msg {
  nx_int32_t routing;
  nx_int16_t overlap;
  nx_int16_t numNodes;
} rout_msg_t;

typedef nx_struct flood_msg {
  nx_int16_t sources[10];
  nx_uint16_t temp;
  nx_uint16_t hum;
  nx_uint16_t wind;
} flood_msg_t;

typedef nx_struct overlap_ping_req {
  nx_uint16_t prot;
  nx_am_addr_t source;
} overlap_ping_req_t;

typedef nx_struct overlap_ping_rep {
  nx_am_addr_t dest;
} overlap_ping_rep_t;

typedef nx_struct universal_msg {
  nx_uint16_t temp;
  nx_uint16_t hum;
  nx_uint16_t wind;
} universal_msg_t;


#endif
