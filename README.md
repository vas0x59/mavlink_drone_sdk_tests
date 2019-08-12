# MAVLINK SDK for indoor drones

Examples for mavlink_indoor_sdk

## Install dependencies
Build and install [mavlink-router](https://github.com/intel/mavlink-router)

## Build dependencies
mavlink_indoor_sdk and markers_lib

## Build
```bash
cmake .
make
```

## Description
udp/tcp_telemtry_test.cpp - connection and commands ( telemetry ) tests\
udp_vpe_sender.cpp - send VPE data to autopilot\
start_router.sh - start [mavlink-router](https://github.com/intel/mavlink-router)


***
by Vasily Yuryev
