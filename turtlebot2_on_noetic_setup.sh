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
        ros-noetic-rgbd-launch \
        libgflags-dev \
        ros-noetic-image-geometry \
        ros-noetic-camera-info-manager \
        ros-noetic-image-transport \
        ros-noetic-image-publisher \
        libgoogle-glog-dev \
        libusb-1.0-0-dev \
        libeigen3-dev
        
sudo apt install -y \
        python-is-python3 \
        python3-vcstool \
        python3-pip \
        libusb-dev \
        libftdi-dev \
        python3-psutil \
        python3-future \
        liborocos-kdl-dev \
        pyqt5-dev-tools
        
# Install libuvc for astra camera
cd ~/
git clone https://github.com/libuvc/libuvc.git
cd libuvc
mkdir build
cd build
cmake .. && make -j4
sudo make install
sudo ldconfig

echo 'source /opt/ros/noetic/setup.bash' >> ~/.bashrc 
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
cp /home/turtlebot/turtlebot2-on-noetic/turtlebot2.rosinstall .
vcs import ./src < ./turtlebot2.rosinstall

echo 'source /opt/ros/noetic/setup.bash' >> ~/.bashrc  # create a path

# Remove unnecessary and incompatible packages
cd ./src
mv yujin_ocs/yocs_cmd_vel_mux yujin_ocs/yocs_controllers yujin_ocs/yocs_velocity_smoother .
rm -rf yujin_ocs

mv linux_Peripheral_interfaces/laptop_battery_monitor .
rm -rf linux_Peripheral_interfaces

# You need to MANUALLY, for now, apply the changes proposed in https://github.com/ros-drivers/linux_peripheral_interfaces/pull/18
rm -rf turtlebot_create_desktop/create_gazebo_plugins
cd ../

# Astro camera setup
cd ~/catkin_ws/src/astra_camera
./scripts/create_udev_rules
sudo udevadm control --reload && sudo  udevadm trigger

cd ~/catkin_ws

echo 'export TURTLEBOT_BATTERY=/sys/class/power_supply/BAT1' >> ~/.bashrc  # Set environment variable TURTLEBOT_BATTERY correctly.
echo 'export TURTLEBOT_3D_SENSOR=astra' >> ~/.bashrc  # Set environment variable TURTLEBOT_BATTERY correctly.


rosdep install --from-paths . --ignore-src -r -y
echo The errors related to the python-orocos-kdl package can be ignored.
echo Refer to https://github.com/yujinrobot/kobuki/issues/427

# Build the packages
catkin_make
