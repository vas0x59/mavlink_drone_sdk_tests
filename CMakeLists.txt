cmake_minimum_required (VERSION 2.6)
project (Mavilink_Indoor_SDK)

include_directories("./src")
include_directories("./mavlink_indoor_sdk/mavlink/v2.0/common")

# Markers
include_directories("./markers_lib/src")

#SDK
include_directories("./mavlink_indoor_sdk/src")

# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

add_executable(tcp_telemetry_test tcp_telemetry_test.cpp)
add_executable(udp_telemetry_test udp_telemetry_test.cpp)

add_executable(udp_vpe_sender udp_vpe_sender.cpp)

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

target_link_libraries(udp_vpe_sender
    #mavlink_indoor_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_indoor_sdk/libmavlink_indoor_sdk.so
    pthread
    ${PROJECT_SOURCE_DIR}/markers_lib/libmarkers_lib.so
    ${OpenCV_LIBS}
)


#zmq


# pkg_check_modules(PC_ZeroMQ QUIET zmq)
# find_path(ZeroMQ_INCLUDE_DIR
#     NAMES zmq.hpp
#     PATHS ${PC_ZeroMQ_INCLUDE_DIRS}
# )

# ## use the hint from about to find the location of libzmq
# find_library(ZeroMQ_LIBRARY
#     NAMES zmq
#     PATHS ${PC_ZeroMQ_LIBRARY_DIRS}
# )
# add_executable(zmq_copter zmq_copter.cpp)

# target_include_directories(zmq_copter ${ZeroMQ_INCLUDE_DIR})
# ## at the 0mq library to our link directive
# target_link_libraries(zmq_copter ${ZeroMQ_LIBRARY})