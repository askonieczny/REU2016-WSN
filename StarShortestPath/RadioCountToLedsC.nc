// $Id: RadioCountToLedsC.nc,v 1.7 2010-06-29 22:07:17 scipio Exp $

/*									tab:4
 * Copyright (c) 2000-2005 The Regents of the University  of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA,
 * 94704.  Attention:  Intel License Inquiry.
 */

#include "Timer.h"
#include "RadioCountToLeds.h"

/**
 * Implementation of the RadioCountToLeds application. RadioCountToLeds
 * maintains a 4Hz counter, broadcasting its value in an AM packet
 * every time it gets updated. A RadioCountToLeds node that hears a counter
 * displays the bottom three bits on its LEDs. This application is a useful
 * test to show that basic AM communication and timers work.
 *
 * @author Philip Levis
 * @date   June 6 2005
 */


module RadioCountToLedsC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface AMPacket;

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
  float numForNode = 0;
  float windForNode = 0;
  float tempForNode = 0;
  float humForNode = 0;
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
    //don't send message if not ready to
    if(locked || !pathPresent || !rcmReceived) { 
      return;
    }

    //send RCM message to next node in path if ready
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
          if (rcm == NULL) {
            return;
          }

          rcm -> wind = windForNode;
          rcm -> hum = humForNode;
          rcm -> temp = tempForNode;
          rcm -> num = numForNode;
          if(path != -1) {
            if (call AMSend.send(path, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
              dbg("RadioCountToLedsC", "Sent radio count packet to %i\n", path);
              locked = TRUE;
            }
          }
    }
  }

  event message_t* Receive.receive(message_t* bufPtr,
				   void* payload, uint8_t len) {
    dbg("RadioCountToLedsC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t) && len != sizeof(path_msg_t))
    {
      return bufPtr;
    }
    else if(len == sizeof(path_msg_t)) {
      //receive path information message, store in path variable
      path_msg_t* pm = (path_msg_t*) payload;
      path = pm -> path;
      dbg("RadioCountToLedsC", "Received instruction to send to %d\n", path);
      pathPresent = TRUE;
      return bufPtr;
    }
    else {
      //receive RadioCountMessage, update current sensing data
      radio_count_msg_t* rcm = (radio_count_msg_t*) payload;
      windForNode += rcm -> wind;
      humForNode += rcm -> hum;
      tempForNode += rcm -> temp;
      numForNode += rcm -> num;
      rcmReceived = TRUE;
      dbg("RadioCountToLedsC", "Current average wind is: %.3f\n", windForNode/numForNode);
      dbg("RadioCountToLedsC", "Current average humidity is: %.3f\n", humForNode/numForNode);
      dbg("RadioCountToLedsC", "Current average temperature is: %.3f\n", tempForNode/numForNode);
            return bufPtr;
  }
  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }

}
