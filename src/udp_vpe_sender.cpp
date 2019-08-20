// #include "src/helpers.h"
#include "drone.h"
#include "tcp.h"
#include "udp.h"
#include <opencv2/opencv.hpp>
#include <opencv2/ximgproc.hpp>
#include <opencv2/aruco.hpp>

#include "markers_lib/src/markers.h"
#include "markers_lib/src/aruco_markers.h"
#include "markers_lib/src/solver.h"

using namespace markers_lib;
using namespace mavlink_indoor_sdk;

ArucoMarkersDetector aruco_detector;
Solver solver;

// Config
string calibration_file = "./log.yml";
string map_url = "./map.txt";
string map_jpeg = "./map.jpg";
int map_jpeg_size = 1000;
int dictinary = 3;
int cam_id = 2;

struct VisionData
{
    Pose pose;
    bool success;
};

VisionData process_img(Mat img)
{
    Mat viz;
    img.copyTo(viz);
    VisionData vd;
    Mat objPoints, imgPoints;
    aruco_detector.detect(img, objPoints, imgPoints, viz);
    // aruco_detector.drawViz(viz);

    // cout << objPoints << "img: " << imgPoints << "\n";
    // Pose pose;
    vd.success = solver.solve(objPoints, imgPoints, vd.pose, viz);
    imshow("Viz", viz);
    return vd;
}

void load_config()
{
    FileStorage fs2("config.yml", FileStorage::READ);
    fs2["map"] >> map_url;
    fs2["calibration_file"] >> calibration_file;

    // fs2["connection_url"] >> connection_url;

    fs2["map_jpeg"] >> map_jpeg;
    fs2["map_jpeg_size"] >> map_jpeg_size;
    fs2["dictinary"] >> dictinary;
    fs2["cam_id"] >> cam_id;
    fs2.release();
}

void init_marker_reg()
{

    solver.load_camera_conf(calibration_file);

    // solver.set_camera_conf(cameraMatrix, distCoeffs);

    aruco_detector.setDictionary(cv::aruco::getPredefinedDictionary(dictinary));

    aruco_detector.loadMap(map_url);
    aruco_detector.genBoard();
    Mat map_img =
        aruco_detector.drawBoard(cv::Size(map_jpeg_size, map_jpeg_size));
    imwrite(map_jpeg, map_img);
}

UDP_Protocol *lw_proto;

int main()
{
    load_config();
    init_marker_reg();

    lw_proto = new UDP_Protocol("udp://127.0.0.1:14510");
    lw_proto->start();

    VideoCapture cap(cam_id);
    while (true)
    {
        if (lw_proto->status == 1)
        {
            mavlink_message_t msg;
            mavlink_vision_position_estimate_t vpe;
            Mat frame;
            cap >> frame;
            VisionData vd = process_img(frame);

            vpe.usec = get_time_usec();
            vpe.x = vd.pose.pose.x;
            vpe.y = vd.pose.pose.y;
            vpe.z = vd.pose.pose.z;

            vpe.roll = vd.pose.rotation.y;
            vpe.pitch = vd.pose.rotation.x;
            vpe.yaw = vd.pose.rotation.z;

            mavlink_msg_vision_position_estimate_encode(12, MAV_COMP_ID_ALL, &msg, &vpe);
            lw_proto->write_message(msg);
            usleep(10000);
        }
    }
    lw_proto->stop();
}