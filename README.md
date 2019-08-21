```
 
 MMMM          
 MMMMM        MM                  ll     i             k         
 MMM MM      MMM                   ll                  k    kk        @@@@@@@@     @@@@@@      @       @
 MMM  MM    MMMM                    l    i  n          k  k          @            @      @    @     @@
 MMM   MM  MM MM   aaaaa   v     v  l    i  nnnnnnn    kk           @            @       @   @   @@
 MMM    MMMM  MM        a  v     v  l    i  n      n   kk            @@@@@@     @       @   @ @  
 MMM          MM   aaaaaa  v     v  l    i  n      n   k kk                @   @       @   @@  @@ 
 MMM          MM  a     a   v   v   ll   i  n      n   k   kk             @   @      @    @      @@
              MM  aaaaaa      v      ll  i  n      n   k     kk   @@@@@@@@   @@@@@@@     @         @
 
                                                                                     by Vasily Yuryev
                                                                                                 2019
 ##          
 ##M          ##                  ##     #             #         
 ## #        ###                   L#                  #    ##        @@@@@@@@     @@@@@@      @       @
 ##  #      # ##                    #    I  #          #  #          @            @      @    @     @@
 M#   #    #  M#   #####   #     V  #    I  #######    #k           @            @       @   @   @@
 ##    #  #   ##        #  #     #  #    #  N      #   ##            @@@@@@     @       @   @@@  
 ##     M#    ##   ##A###  V     #  #    #  #      #   # ##                @   @       @   @   @@ 
 ##           #M  #     #   #   #   ##   #  #      #   #   ##             @   @      @    @      @@
              ##  #A####      #      #L  #  #      N   #     #k   @@@@@@@@   @@@@@@@     @         @
              
                                                                                     by Vasily Yuryev
                                                                                                 2019
```

# MAVLINK SDK for indoor drones

Examples for [mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)

## Dependencies

### Install dependencies
Build and install [mavlink-router](https://github.com/intel/mavlink-router)

### Submodules
```bash
git submodule update --init --recursive
```

### Build dependencies
 - [mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)
 - [markers_lib](https://github.com/vas59/markers_lib)
```bash
# this arch
./build_all.sh 1 1/0 #init or just build#
# Raspberry PI
./build_all.sh arm 1/0 #init or just build#
```

## Build
```bash
# this arch
./build.sh 1 1/0 #init or just build#
# Raspberry PI
./build.sh arm 1/0 #init or just build#
```
## Deploy
```bash
# For Raspberry PI
./deploy.sh
```
## Description
udp/tcp_telemtry_test.cpp - connection and commands ( telemetry ) tests\
udp_vpe_sender.cpp - send VPE data to autopilot\
start_router.sh - start [mavlink-router](https://github.com/intel/mavlink-router)

## Run
### On Raspberry PI
```bash
./run_prog.sh #program name#
```
### On Raspberry PI remotely
```bash
# Run on laptop
./run_on_raspi.sh #program name# 
```
## Project repositories
 - [mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk) - Mavlink Indoor SDK source
 - [markers_lib](https://github.com/vas59/markers_lib)- Library for aruco navigation
 - [opencv_image_transfer](https://github.com/vas59/opencv_image_transfer) - send image form c++
 - [led_uart_cpp](https://github.com/vas59/led_uart_cpp) - ws2812(arduino) control over uart 
 - [led_uart_ws2812_arduino](https://github.com/vas59/led_uart_ws2812_arduino) - ws2812(arduino) control over uart
 - [PX4 Firmware](https://github.com/vas59/PX4_Firmware) - version of px4 for Spurk
 - [ESP32 mqtt swarm control](https://github.com/vas59/mavlink_indoor_sdk_esp32_test1) - ESP32 version of [vas59/mavlink_indoor_sdk](https://github.com/vas59/mavlink_indoor_sdk)
 - [Prebuilt for Raspberry PI](https://github.com/vas59/raspberrypi_prebuilt/releases)
***
by Vasily Yuryev
