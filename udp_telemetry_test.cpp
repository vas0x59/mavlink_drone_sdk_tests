// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"

using namespace mavlink_indoor_sdk;

int main(){
    UDP_Protocol lw_proto("udp://127.0.0.1:14530");
    lw_proto.start();
    
    autopilot_interface::AutopilotInterface ai(&lw_proto);

    Drone drone(&ai);
    drone.start();

    // ai.system_id = 1;
    drone.arm();
    // drone.takeoff(1.5, 0.5);
    drone.set_position({0, 0, 4, 0}, FRAME_LOCAL);
    // drone.set_position({0, 1, 2, 0}, FRAME_VISION);
    // drone.sleep(50*60000);
    drone.sleep(1000);
    // drone.set_position({0, 1, 2, 0}, FRAME_VISION);
    drone.navigate_wait({0, 0, 2, 0}, FRAME_LOCAL, 0.5);
    drone.navigate_wait({2, 2, 2, 0}, FRAME_LOCAL, 0.5);
    // drone.sleep(10000);
    // // drone.set_position({0, 1, 2, 0}, FRAME_VISION);
    // drone.navigate({-2, -2, 2, 0}, FRAME_LOCAL, 0.5);
    while (true){
        cout << "Local " << drone.get_telemetry(FRAME_LOCAL).ToString();
        cout << "Vision " << drone.get_telemetry(FRAME_VISION).ToString();
        drone.sleep(333);
    }

    // drone.navigate_wait({0, 0, 2, 0}, FRAME_LOCAL, 1.5);
    
    // drone.sleep(3000);

    // drone.navigate_wait({-2, 0, 2, 0}, FRAME_LOCAL, 0.5);
    
    // drone.sleep(3000);

    // drone.navigate_wait({0, 0, 2, 1.57}, FRAME_LOCAL, 0.5);
    // drone.set_position({0, 0, 2, 1.57}, FRAME_LOCAL);
    // drone.sleep(3000);
    // drone.arm();
    // drone.takeoff(1.5, 0.5);

    // drone.navigate({0, 0, 2, 0}, FRAME_VISION, 0.5);

    drone.land();
    // drone.sleep(5000);
    // drone.disarm();

    drone.stop();
    lw_proto.stop();
}
