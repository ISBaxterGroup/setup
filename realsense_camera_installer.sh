#!/bin/bash
cd ~/catkin_ws/src/
git clone https://github.com/ISBaxterGroup/realsense_camera.git
sudo cp realsense_camera/config/80-realsense-usb.rules /etc/udev/rules.d  
sudo apt-get install libudev-dev libv4l-dev libusb-1.0-0-dev
sudo apt-get install ros-groovy-pcl-conversions
cd ~/catkin_ws/
echo "----- REBOOT to reload the rule and REBUILD realsense_camera -----"  