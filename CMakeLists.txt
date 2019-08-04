cmake_minimum_required (VERSION 2.6)
project (Mavilink_Indoor_SDK)

include_directories("./src")
include_directories("./mavlink/v2.0/common")

# Markers
include_directories("./markers_lib/src")

#SDK
include_directories("./mavlink_indoor_sdk/src")

add_executable(tcp_telemetry_test tcp_telemetry_test.cpp)
add_executable(udp_telemetry_test udp_telemetry_test.cpp)

add_executable(tcp_vpe_sender tcp_vpe_sender.cpp)

# add_executable(hwer hwer.cpp)
target_link_libraries(tcp_telemetry_test
    #mavlink_indoor_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_indoor_sdk/libmavlink_indoor_sdk.so
    pthread
)

target_link_libraries(udp_telemetry_test
    #mavlink_indoor_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_indoor_sdk/libmavlink_indoor_sdk.so
    pthread
)

find_package( OpenCV REQUIRED )

target_link_libraries(tcp_vpe_sender
    #mavlink_indoor_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_indoor_sdk/libmavlink_indoor_sdk.so
    pthread
    ${PROJECT_SOURCE_DIR}/markers_lib/libmarkers_lib.so
    ${OpenCV_LIBS}
)
