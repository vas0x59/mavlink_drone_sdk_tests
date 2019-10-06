// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

using namespace mavlink_drone_sdk;

Drone *drone;
autopilot_interface::AutopilotInterface *ai;
LowLevel *lwproto;

void quit_handler(int sig);

void usage()
{
    cout << "Usage: url"
         << "\n";
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
    ai->wait_for_init_pose = false;
    drone = new Drone(ai);
    lwproto->start();

    // lwproto_quit = &lw_proto;
    // drone_quit = &drone;

    signal(SIGINT, quit_handler);

    drone->start();
    
    while (true){
        LogInfo("BODY", drone->get_telemetry(FRAME_BODY).ToString());
        LogInfo("VISION", drone->get_telemetry(FRAME_VISION).ToString());
        drone->sleep(333);
    }

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