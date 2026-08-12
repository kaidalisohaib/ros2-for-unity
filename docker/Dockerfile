ARG ROS2_DISTRO=jazzy
FROM ros:${ROS2_DISTRO}-ros-base

# ROS 2 middleware packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-test-msgs \
    ros-${ROS_DISTRO}-fastrtps \
    ros-${ROS_DISTRO}-rmw-fastrtps-cpp \
    ros-${ROS_DISTRO}-cyclonedds \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# Build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget git python3-vcstool apt-transport-https patchelf \
    && rm -rf /var/lib/apt/lists/*

# .NET 8 SDK (LTS - recommended for netstandard2.0 targets)
RUN apt-get update && apt-get install -y --no-install-recommends \
    dotnet-sdk-8.0 \
    && rm -rf /var/lib/apt/lists/*

# Dev headers so CMake can locate and bundle OS libraries into standalone
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfmt-dev \
    libtinyxml2-dev \
    && rm -rf /var/lib/apt/lists/*

ADD docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
