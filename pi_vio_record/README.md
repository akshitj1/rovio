# Offline VIO data record with Raspberry Pi

Rovio is meant to run online, but for your first run you will want to make it first work on offline data, As this will speed up your testing and you don't have to stay connected to 
pi all the time. Just record once and then use your Workstation or GCP remote ubuntu to work on this offline data. This directory contains all the code needed to capture and record visual and inertial data. 

If some instructions are missing, read containing code. I am pushing this code some months after running.

```bash
# install dependencies. Note: I tried to recollect these from command history. All below dependencies might not even be needed, use your own judegement
sudo apt-get install raspi-config libraspberrypi-dev i2c-tools
pip install picamera

# on pi place this directory contents to ~/catkin_ws/src
# build nodes
catkin_make

# start sensors capture and record to bag format
roslaunch vio_node visual_inertial_record.launch
```

