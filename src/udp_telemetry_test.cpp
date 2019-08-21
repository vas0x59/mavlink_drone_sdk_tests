// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

using namespace mavlink_indoor_sdk;

Drone *drone;
autopilot_interface::AutopilotInterface *ai;
LowLevel *lwproto;

void quit_handler(int sig);

void usage()
{
    cout << "Usage: url"
         << "\n";
}

void circle(float radius, PointXYZ centre, PointXYZ start, Frame frame, float part = 2 * M_PI, int res = 30)
{

    for (float i = 0; i < res; i++)
    {
        float p = (i / res) * part;
        // float
        PointXYZ now = centre + PointXYZ(cosf(p) * radius, sinf(p) * radius, 0);
        LogInfo("CIRCLE", now.ToString());
        drone->navigate_wait({now.x, now.y, now.z, 0}, frame, 2);
        // drone->sleep(500);
    }
}

int main(int argc, char **argv)
{
    if (argc <= 1)
    {
        LogError("", "Argumets is not correct");
        usage();
        return 1;
    }

    LogInfo("", "udp_telemetry_test.cpp");

    lwproto = new UDP_Protocol("udp://" + string(argv[1]));

    // lw_proto_ = &lw_proto;

    ai = new autopilot_interface::AutopilotInterface(lwproto);

    drone = new Drone(ai);
    lwproto->start();

    // lwproto_quit = &lw_proto;
    // drone_quit = &drone;

    signal(SIGINT, quit_handler);

    drone->start();
    // ai.system_id = 1;
    drone->arm();
    // drone->takeoff(1.5, 0.5);
    drone->set_position({0, 0, 2, 0}, FRAME_LOCAL);
    drone->sleep(3000);
    // drone->navigate_wait({0, 0, 2, 0}, FRAME_LOCAL, 0.5);
    // drone->sleep(3000);
    circle(100, {0, 0, 2}, {0, 0, 2}, FRAME_LOCAL);

    drone->navigate_wait({2, 0, 2, 0}, FRAME_LOCAL, 0.5);

    drone->sleep(3000);

    drone->navigate_wait({-2, 0, 2, 0}, FRAME_LOCAL, 0.5);

    drone->sleep(3000);

    drone->navigate_wait({0, 0, 2, 1.57}, FRAME_LOCAL, 0.5);
    // drone->set_position({0, 0, 2, 1.57}, FRAME_LOCAL);
    drone->sleep(3000);
    // drone->arm();
    // drone->takeoff(1.5, 0.5);

    // drone->navigate({0, 0, 2, 0}, FRAME_VISION, 0.5);

    drone->land();
    // drone->sleep(5000);
    // drone->disarm();

    drone->stop();
    lwproto->stop();
}

void quit_handler(int sig)
{
    LogWarn("", "TERMINATING AT USER REQUEST");
    // autopilot interface
    try
    {
        drone->handle_quit(sig);
    }
    catch (int error)
    {
    }
    try
    {
        lwproto->handle_quit(sig);
    }
    catch (int error)
    {
    }

    exit(0);
}