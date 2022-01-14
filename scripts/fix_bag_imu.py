import numpy as np
import rosbag

def to_rads_sec(deg_sec):
    return float(np.deg2rad(deg_sec))

def fix_bag_data():
    data_dir='/home/akshitjain/catkin_ws/data'
    bag_file_name = 'cam_imu'
    in_bag_file = "{}/{}.bag".format(data_dir, bag_file_name)
    out_bag_file = "{}/{}_fixed.bag".format(data_dir, bag_file_name)


    with rosbag.Bag(out_bag_file, 'w') as outbag:
        for topic, msg, t in rosbag.Bag(in_bag_file).read_messages():
            if topic == "/vio/imu":
                msg.angular_velocity.x = to_rads_sec(msg.angular_velocity.x)
                msg.angular_velocity.y = to_rads_sec(msg.angular_velocity.y)
                msg.angular_velocity.z = to_rads_sec(msg.angular_velocity.z)

            outbag.write(topic, msg, msg.header.stamp)    

if __name__ == '__main__':
    fix_bag_data()
