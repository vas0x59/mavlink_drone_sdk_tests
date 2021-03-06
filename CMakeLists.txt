cmake_minimum_required (VERSION 2.6)
project (Mavilink_Indoor_SDK)

add_definitions("-D_USE_MATH_DEFINES")
add_definitions("-std=gnu++11")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
# add_definitions("-rpath-link")

include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${PROJECT_SOURCE_DIR}/mavlink_drone_sdk/mavlink/v2.0/common)

# Markers
include_directories(${PROJECT_SOURCE_DIR}/markers_lib/src)

#SDK
include_directories(${PROJECT_SOURCE_DIR}/mavlink_drone_sdk/src)

#img sender
include_directories(${PROJECT_SOURCE_DIR}/opencv_image_transfer/src)



#OpenCV
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )

#zmq
# pkg_check_modules(PC_ZeroMQ QUIET zmq)
# find_path(ZeroMQ_INCLUDE_DIR
#     NAMES zmq.hpp
#     PATHS ${PC_ZeroMQ_INCLUDE_DIRS}
# )

# # ## use the hint from about to find the location of libzmq
# find_library(ZeroMQ_LIBRARY
#     NAMES zmq
#     PATHS ${PC_ZeroMQ_LIBRARY_DIRS}
# )
# include_directories(${ZeroMQ_INCLUDE_DIR})


# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

add_executable(tcp_telemetry_test src/tcp_telemetry_test.cpp)
add_executable(udp_telemetry_test src/udp_telemetry_test.cpp)
add_executable(udp_vpe_sender     src/udp_vpe_sender.cpp)

# add_executable(hwer hwer.cpp)
target_link_libraries(tcp_telemetry_test
    # mavlink_drone_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_drone_sdk/${DEP2_BUILD_DIR}/libmavlink_drone_sdk.so
    pthread
)

target_link_libraries(udp_telemetry_test
    # mavlink_drone_sdk
    ${PROJECT_SOURCE_DIR}/mavlink_drone_sdk/${DEP2_BUILD_DIR}/libmavlink_drone_sdk.so
    pthread
)

target_link_libraries(udp_vpe_sender
    # mavlink_drone_sdk
    ${OpenCV_LIBS}
    ${PROJECT_SOURCE_DIR}/mavlink_drone_sdk/${DEP2_BUILD_DIR}/libmavlink_drone_sdk.so
    pthread
    ${PROJECT_SOURCE_DIR}/markers_lib/${DEP2_BUILD_DIR}/libmarkers_lib.so
    # ${PROJECT_SOURCE_DIR}/opencv_image_transfer/${DEP2_BUILD_DIR}/libopencv_image_transfer.so
)


# add_executable(zmq_copter zmq_copter.cpp)


# ## at the 0mq library to our link directive
# target_link_libraries(udp_vpe_sender ${ZeroMQ_LIBRARY})
