// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

using namespace mavlink_drone_sdk;

Drone *drone_quit;
LowLevel *lwproto_quit;

void quit_handler(int sig);

void usage()
{
    cout << "Usage: ip:port"
         << "\n";
}

int main(int argc, char** argv)
{
    if (argc <= 1)
    {
        LogError("", "Argumets is not correct");
        usage();
        return 1;
    }

    LogInfo("", "tcp_telemetry_test.cpp");
    
    TCP_Protocol lw_proto("tcp://" + string(argv[1]));

    autopilot_interface::AutopilotInterface ai(&lw_proto);
    ai.wait_for_init_pose = false;
    Drone drone(&ai);
    lw_proto.start();

    lwproto_quit = &lw_proto;
    drone_quit = &drone;

    signal(SIGINT, quit_handler);

    drone.start();

    // ai.system_id = 1;
    while (true){
        LogInfo("BODY", drone.get_telemetry(FRAME_BODY).ToString());
        LogInfo("VISION", drone.get_telemetry(FRAME_VISION).ToString());
        drone.sleep(333);
    }
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