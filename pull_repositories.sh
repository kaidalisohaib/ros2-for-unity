#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

if [ -z "${ROS_DISTRO}" ]; then
    echo "Can't detect ROS2 version. Source your ros2 distro first. Foxy, Galactic, Humble, Jazzy are supported"
    exit 1
fi

echo "========================================="
echo "* Pulling/updating ros2cs repository:"
if [ -d "src/ros2cs/.git" ]; then
    git -C "src/ros2cs" pull
else
    vcs import < "ros2cs.repos"
fi

echo ""
echo "========================================="
echo "Pulling custom repositories:"
vcs import < "ros2_for_unity_custom_messages.repos"

echo ""
echo "========================================="
echo "Pulling ros2cs dependencies:"
cd "$SCRIPTPATH/src/ros2cs"
./get_repos.sh
cd -
