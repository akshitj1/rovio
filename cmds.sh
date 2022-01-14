#!/bin/bash

# bulid
catkin build rovio -DMAKE_SCENE=ON -j1 --mem-limit 4g --verbose

# run
roslaunch rovio rovio_node.launch
rosbag play /home/akshitjain/catkin_ws/data/cam_imu_fixed.bag

# create april tag
rosrun kalibr kalibr_create_target_pdf --type apriltag --nx 4 --ny 5 --tsize 0.037 --tspace 0.3

# camera instrinsics
rosrun kalibr kalibr_calibrate_cameras \
 --bag data/cam_imu_calibrate_big.bag \
 --topics /vio/raspicam_node/image \
 --models pinhole-equi \
 --target data/config/aprilgrid_big.yaml \
 --bag-from-to 2.5 57

# camera to imu transformation
rosrun kalibr kalibr_calibrate_imu_camera \
 --bag data/cam_imu_calibrate_big.bag \
 --cam camchain-data/cam_imu_calibrate_big.yaml \
 --imu data/config/imu_mpu6050.yaml \
 --target data/config/aprilgrid_big.yaml \
 --bag-from-to 2.5 57 \
 --no-time-calibration

# config compatible with rovio
rosrun kalibr kalibr_rovio_config --cam camchain-imucam-data/cam_imu_calibrate_big.yaml
# copy just camera to imu transform params from *.info file.copy rovio_cam.yaml as it is

# trim bag file
rosbag filter cam_imu.bag cam_imu_trimmed.bag "t.secs >= 1641797526.72"