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
        pyqt5-dev-tools

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
vcs import ./src < ~/turtlebot.rosinstall
