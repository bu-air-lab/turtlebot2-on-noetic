sudo apt update -y && sudo apt upgrade -y

# Install dependenceis for building packages and some useful packages
sudo apt install -y --no-install-recommends \
        apt-utils \
        build-essential \
        ca-certificates \
        pkg-config \
        curl \
        wget \
        vim \
        zip \
        unzip \
        git \
        kmod \
        libelf-dev \
        cmake 
        
# Installation
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update -y
sudo apt install ros-noetic-desktop-full -y
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Install some other dependencies
sudo apt install -y \
        python3-rosdep \
        python3-rosinstall \
        python3-rosinstall-generator \
        python3-wstool

# Initialize rosdep
# Before you can use many ROS tools, you will need to initialize rosdep. 
# rosdep enables you to easily install system dependencies for source you 
# want to compile and is required to run some core components in ROS. 
sudo rosdep init
rosdep update

# Install catkin_tools package that provides command line tools for working with the catkin meta-buildsystem and catkin workspaces.
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y python3-catkin-tools
