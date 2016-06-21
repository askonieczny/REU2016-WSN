#ifndef SUM_NODES_H
#define SUM_NODES_H

typedef nx_struct radio_count_msg {
  nx_uint16_t val;
} radio_count_msg_t;

typedef nx_struct path_msg {
  nx_int32_t path;
} path_msg_t;

enum {
  AM_RADIO_COUNT_MSG = 6,
};


#endif
