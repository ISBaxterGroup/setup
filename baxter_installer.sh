#!/bin/bash
echo "ros indigo install"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full
sudo rosdep init
rosdep update
sudo apt-get install python-rosinstall

echo "workspace setup"
mkdir -p ~/ros_ws/src
source /opt/ros/indigo/setup.bash
cd ~/ros_ws
catkin_make
catkin_make install

echo "install baxter sdk"
sudo apt-get update
sudo apt-get install git-core python-argparse python-wstool python-vcstools python-rosdep ros-indigo-control-msgs ros-indigo-joystick-drivers
sudo apt-get update
sudo apt-get install ros-indigo-baxter-sdk

echo "wget baxter sh"
wget https://github.com/RethinkRobotics/baxter/raw/master/baxter.sh
chmod u+x baxter.sh

echo "workspace setup"
source /opt/ros/indigo/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws/
catkin_make #The catkin_make command is a convenience tool for working with catkin workspaces.
catkin_make install  # (optionally)
source devel/setup.bash

echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
echo "alias bax='cd ~/ros_ws;  ./baxter.sh'" >> ~/.bashrc

echo "baxter.sh setting"
echo "*************************************************************"
echo "Rewrite baxter_hostname in ~/ros_ws/baxter.sh line 22"
echo "Our baxter host name is \"011312P0018.local\""
echo "*************************************************************"
echo -n "Did you end editing? [y/n] > "
while :
do
  read INPUT
  case "$INPUT" in
    "y" ) break ;;
    "n" ) echo "Rewrite baxter_hostname in ~/ros_ws/baxter.sh line 22";;
    * )   echo "input in [y/n]" ;;
  esac
done  

echo "*************************************************************"
echo "Rewrite your_ip in ~/ros_ws/baxter.sh line 26"
echo "*************************************************************"
echo -n "Did you end editing? [y/n] > "
while :
do
  read INPUT
  case "$INPUT" in
    "y" ) break ;;
    "n" ) echo "Rewrite baxter_hostname in ~/ros_ws/baxter.sh line 22";;
    * )   echo "input in [y/n]" ;;
  esac
done  
echo "*************************************************************"
echo "Append the following sentence to the next Line of your_ip (line 26)"
echo "source ~/catkin_ws/devel/setup.bash"
echo "*************************************************************"
echo -n "Did you end editing? [y/n] > "
while :
do
  read INPUT
  case "$INPUT" in
    "y" ) break ;;
    "n" ) echo "append \"source ~/catkin_ws/devel/setup.bash\"";;
    * )   echo "input in [y/n]" ;;
  esac
done  
echo "*************************************************************"
echo "Rewrite ros_version in ~/ros_ws/baxter.sh line 30"
echo "Our ros version is \"indigo\""
echo "*************************************************************"
echo -n "Did you end editing? [y/n] > "
while :
do
  read INPUT
  case "$INPUT" in
    "y" ) break ;;
    "n" ) echo "Rewrite ros_version to indigo";;
    * )   echo "input in [y/n]" ;;
  esac
done  
echo "*************************************************************"
echo "Append the following sentence to ~/ros_ws/baxter.sh line 153"
echo -e ",to the next of \"# source the catkin setup bash script\nsource devel/setup.bash\""
echo "source ~/.bashrc"
echo "*************************************************************"
echo -n "Did you end editing? [y/n] > "
while :
do
  read INPUT
  case "$INPUT" in
    "y" ) break ;;
    "n" ) echo "append \"source ~/.bashrc\" to ~/ros_ws/baxter.sh line 153";;
    * )   echo "input in [y/n]" ;;
  esac
done  

echo "lis_package"
cd ~/catkin_ws/src
git clone https://github.com/ISBaxterGroup/lis-ros-pkg.git
echo "lis_package-copy"
cd ~/catkin_ws/
mkdir -p ~/catkin_ws/devel/include/lis_msgs/
cp ~/catkin_ws/src/lis-ros-pkg/lis_msgs/include/lis.h ~/catkin_ws/devel/include/lis_msgs/
cp ~/catkin_ws/src/lis-ros-pkg/lis_msgs/include/msg_helpers.h ~/catkin_ws/devel/include/
echo "lis_package-remov"
mv ~/catkin_ws/src/lis-ros-pkg/* ~/catkin_ws/src/
sudo rm -r lis-ros-pkg

echo "make"
cd ~/catkin_ws
catkin_make -DCATKIN_WHITELIST_PACKAGES="lis_msgs"
catkin_make -DCATKIN_WHITELIST_PACKAGES="lis_msgs"
catkin_make -DCATKIN_WHITELIST_PACKAGES=""

