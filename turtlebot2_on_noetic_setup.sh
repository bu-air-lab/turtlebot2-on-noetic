sudo apt update -y
sudo apt install -y \
        ros-noetic-joy \
        ros-noetic-ecl-build \
        ros-noetic-ecl-threads \
        ros-noetic-ecl-geometry \
        ros-noetic-ecl-console \
        ros-noetic-ecl-mobile-robot \
        ros-noetic-ecl-devices \
        ros-noetic-ecl-sigslots \
        ros-noetic-ecl-command-line \
        ros-noetic-ecl-streams \
        ros-noetic-base-local-planner \
        ros-noetic-move-base \
        ros-noetic-kobuki-ftdi \
        ros-noetic-rgbd-launch
        
sudo apt install -y \
        python3-vcstool \
        python3-pip \
        libusb-dev \
        libftdi-dev \
        python3-psutil \
        python3-future \
        liborocos-kdl-dev \
        pyqt5-dev-tools

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
vcs import ./src < ~/turtlebot.rosinstall

# Remove unnecessary and incompatible packages
cd ./src
mv yujin_ocs/yocs_cmd_vel_mux yujin_ocs/yocs_controllers yujin_ocs/yocs_velocity_smoother .
rm -rf yujin_ocs
mv linux_Peripheral_interfaces/laptop_battery_monitor .
rm -rf linux_Peripheral_interfaces
# You need to MANUALLY, for now, apply the changes proposed in https://github.com/ros-drivers/linux_peripheral_interfaces/pull/18
cd ../

echo "The errors related to the python-orocos-kdl package can be ignored."
echo "Refer to https://github.com/yujinrobot/kobuki/issues/427"
rosdep install --from-paths . --ignore-src -r -y

# Build the packages
catkin_make
