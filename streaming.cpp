/**
 * This file inherits datachannel and mediastream
 * from webrtc.
 * The goal of this file is to stream video from server
 * to client.
 */

#include <api/data_channel_interface.h>
#include <api/media_stream_interface.h>

/**
 * When streaming with WebRTC, you need these two:
 *   data channel
 *   streaming channel
 * 
 * DataChannelInterface in api/data_channel_interface.h has a virtual method called
 * "Send", which sends data to remote peer.
 * In this file, we will make a namespace test for this sample application.
 * The test namespace will contain TestStream class inheriting DataChannelInterface.
 */
namespace test {
    class TestStream : public webrtc::DataChannelInterface {
        // The method "Send" sends buffer to remote peer.
        // TODO: implement the inheriting Send method.
        bool Send(const webrtc::DataBuffer& buffer){
            
        }
    };
}