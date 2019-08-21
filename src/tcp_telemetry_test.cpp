// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

using namespace mavlink_indoor_sdk;

Drone *drone_quit;
LowLevel *lwproto_quit;

void quit_handler(int sig);

int main()
{
    LogInfo("", "tcp_telemetry_test.cpp");

    TCP_Protocol lw_proto("tcp://192.168.43.238:5760");

    autopilot_interface::AutopilotInterface ai(&lw_proto);

    Drone drone(&ai);
    lw_proto.start();

    lwproto_quit = &lw_proto;
    drone_quit = &drone;

    signal(SIGINT,quit_handler);

    drone.start();

    // ai.system_id = 1;
    drone.arm();
    // drone.takeoff(1.5, 0.5);
    drone.set_position({0, 0, 2, 0}, FRAME_LOCAL);
    drone.sleep(3000);

    drone.navigate_wait({2, 0, 2, 0}, FRAME_LOCAL, 1.5);

    drone.sleep(3000);

    drone.navigate_wait({-2, 0, 2, 0}, FRAME_LOCAL, 0.5);

    drone.sleep(3000);

    drone.navigate_wait({0, 0, 2, 1.57}, FRAME_LOCAL, 0.5);
    // drone.set_position({0, 0, 2, 1.57}, FRAME_LOCAL);
    drone.sleep(3000);
    // drone.arm();
    // drone.takeoff(1.5, 0.5);

    // drone.navigate({0, 0, 2, 0}, FRAME_VISION, 0.5);

    drone.land();
    // drone.sleep(5000);
    // drone.disarm();

    drone.stop();
    lw_proto.stop();
}

void quit_handler(int sig)
{
    LogWarn("", "TERMINATING AT USER REQUEST");
    // autopilot interface
    try
    {
        drone_quit->handle_quit(sig);
    }
    catch (int error)
    {
    }
    try
    {
        lwproto_quit->handle_quit(sig);
    }
    catch (int error)
    {
    }

    exit(0);
}