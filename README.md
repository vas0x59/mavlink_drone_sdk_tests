# MAVLINK SDK for indoor drones

Examples for [mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)

## Install dependencies
Build and install [mavlink-router](https://github.com/intel/mavlink-router)

## Build dependencies
 - [mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)
 - [markers_lib](https://github.com/vas59/markers_lib)

## Build
```bash
cmake .
make
```

## Description
udp/tcp_telemtry_test.cpp - connection and commands ( telemetry ) tests\
udp_vpe_sender.cpp - send VPE data to autopilot\
start_router.sh - start [mavlink-router](https://github.com/intel/mavlink-router)

## Project repositories
 - [vas59/mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk) - Mavlink Indoor SDK source
 - [vas59/markers_lib](https://github.com/vas59/markers_lib)- Library for aruco navigation
 - [vas59/opencv_image_transfer](https://github.com/vas59/opencv_image_transfer) - send image form c++
 - [vas59/led_uart_cpp](https://github.com/vas59/led_uart_cpp) - ws2812(arduino) control over uart 
 - [led_uart_ws2812_arduino](https://github.com/vas59/led_uart_ws2812_arduino) - ws2812(arduino) control over uart
 - [PX4 Firmware](https://github.com/vas59/PX4_Firmware) - version of px4 for Spurk
 - [ESP32 mqtt swarm control](https://github.com/vas59/mavlink_indoor_sdk_esp32_test1) - ESP32 version of [vas59/mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)

***
by Vasily Yuryev
