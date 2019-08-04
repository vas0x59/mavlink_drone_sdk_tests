// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

using namespace mavlink_indoor_sdk;

int main(){
    TCP_Protocol lw_proto("tcp://127.0.0.1:5760");
    lw_proto.start();
    
    autopilot_interface::AutopilotInterface ai(&lw_proto);

    Drone drone(&ai);
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