# WebRTC C++ sample
**This work is origined from https://github.com/llamerada-jp/webrtc-cpp-sample.git by Yuji Ito.**
This is an example program using WebRTC(DataChannel) on C++.

# Requirement
* Mac OSX
* Ubuntu

# Compile
``` sh
$ cd <path to work>
$ git clone --depth 1 https://github.com/hipiphock/webrtc-cpp-sample.git
$ cd webrtc-cpp-sample
$ git submodule init
$ git submodule update
$ sh build.sh
```

# Run
The example consists of two programs: server and client.
Each of them uses a console to do interprocess communication by WebRTC.
It may not communicate over NAT each other, because it does not use ICE server.

## Basic Procedure
This consists of two app: client and server.
1. The **client** first do sdp1, and create message.
2. Then, the **server** do sdp2, and put the message created by client with sdp1 command. Then, server will create answer for the message.
3. The client then do sdp3, with the message created by server.
4. The client will call ice1 creating message.
5. The server will do ice2, and put the message from ice1. That will generate another message from server.
6. The server will do ice1, creating message.
6. The client will put the message from ice1 by server, and the connection will be established.

## Connection
memo : On this sample, Some commands requireing parameter need line of only a semicolon after parameter.

At client:

``` sh
$ cd <path to work>
$ ./client.out
0x7fff791c9000:Main thread
0x700000081000:RTC thread
sdp1
0x700000081000:PeerConnectionObserver::RenegotiationNeeded
0x700000081000:CreateSessionDescriptionObserver::OnSuccess
0x700000081000:PeerConnectionObserver::SignalingChange(1)
Offer SDP:begin
<Copy displayed string to the clipboard as STRING-A.>
Offer SDP:end
0x700000081000:SetSessionDescriptionObserver::OnSuccess
0x700000081000:PeerConnectionObserver::IceGatheringChange(1)
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceGatheringChange(2)
sdp3
<Paste STRING-B that it displayed on CONSOLE-2.>
;
0x700000081000:PeerConnectionObserver::SignalingChange(0)
0x700000081000:PeerConnectionObserver::IceConnectionChange(1)
0x700000081000:SetSessionDescriptionObserver::OnSuccess
ice1
<Copy displayed string to the clipboard as STRING-C.>
0x700000081000:PeerConnectionObserver::IceConnectionChange(2)
0x700000081000:PeerConnectionObserver::IceConnectionChange(3)
0x700000081000:DataChannelObserver::StateChange
0x700000081000:PeerConnectionObserver::DataChannel(0x7fd8cb608750, 0x7fd8cb71bef0)
ice2
<Paste STRING-D that it displayed on CONSOLE-2.>
;
```

At server:

```sh
$ cd <path to work>
$ ./server.out
0x7fff791c9000:Main thread
0x700000081000:RTC thread
sdp2
<Paste STRING-A that it displayed on CONSOLE-1.>
;
0x700000081000:PeerConnectionObserver::RenegotiationNeeded
0x700000081000:PeerConnectionObserver::SignalingChange(3)
0x700000081000:SetSessionDescriptionObserver::OnSuccess
0x700000081000:CreateSessionDescriptionObserver::OnSuccess
0x700000081000:PeerConnectionObserver::SignalingChange(0)
Answer SDP:begin
<Copy displayed string to the clipboard as STRING-B.>
Answer SDP:end
0x700000081000:SetSessionDescriptionObserver::OnSuccess
0x700000081000:PeerConnectionObserver::IceGatheringChange(1)
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceCandidate
0x700000081000:PeerConnectionObserver::IceGatheringChange(2)
ice2
<Paste STRING-C that it displayed on CONSOLE-1.>
;
0x700000081000:PeerConnectionObserver::IceConnectionChange(1)
0x700000081000:PeerConnectionObserver::IceConnectionChange(2)
0x700000081000:DataChannelObserver::StateChange
0x700000081000:PeerConnectionObserver::DataChannel(0x7fa739e0c0d0, 0x7fa739e08b80)
ice1
<Copy displayed string to the clipboard as STRING-D.>
```

## Send message
You can send messages, after connection is enabled.
```
send
Hello world.
;
```
make sure that you put ";" on your last word.

## Quit
You can watch sequence of quit by typing of "quit".
```
quit
```

# Current Issues in this work
 * server.out is having problem(seg fault). Going to fix it soon.

# Further TODO List:
1. Implement client-server video streaming.
2. Do the video streaming directly from frame buffer.

display engine - out monitor - fetching api?
frame buffer - how to fetch?