#!/bin/bash


for var in mavlink_indoor_sdk markers_lib led_uart_cpp opencv_image_transfer
do
    echo "./$var"
    (cd "./$var" && ./build.sh $1 $2)
    
done

# if ["$arch" == "arm"] ; 
# then
#     echo "arm"
#     if "$rebuild"; then
#         rm -rf build_arm
#         mkdir build_arm
#     fi
#     cd build_arm
#     cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_TOOLCHAIN_FILE=$HOME/rpi/toolchain_rpi.cmake ..
#     make 
# else
#     echo "this"
#     if "$rebuild"; then
#         rm -rf build
#         mkdir build
#     fi
#     cd build
#     cmake -D CMAKE_BUILD_TYPE=RELEASE ..
#     make
# fi