# ROS2 For Unity - Ubuntu 20.04, 22.04, and 24.04

This readme contains information specific to Ubuntu 20.04/22.04/24.04. For general information, please see [README.md](README.md)

## Building

We assume that working directory is `~/ros2-for-unity` and we are using `ROS2 galactic` (replace with `foxy`, `humble`, `jazzy` or `rolling` where applicable).

### Prerequisites

Start with installation of dependencies. Make sure to complete each step of `ros2cs` [Prerequisites section](https://github.com/RobotecAI/ros2cs/blob/master/README-UBUNTU.md#prerequisites).

### Building with Docker Compose (Recommended)

Building with Docker Compose is the recommended approach as it handles all build dependencies automatically inside a containerized environment.

#### Option A: Automated One-Command Build
```bash
# Build the standalone asset automatically
docker compose up --build
# Output asset will be generated in install/asset/Ros2ForUnity/
```

#### Option B: Interactive Shell Mode (Step-by-Step / Debugging)
```bash
# Start an interactive container bash shell
docker compose run --rm builder bash

# Inside container:
./pull_repositories.sh
./build.sh --standalone
exit
```

#### Custom Messages Support
To include custom ROS 2 messages when building with Docker Compose:
- **Local directory**: Drop ROS 2 message package folders into `custom_messages/` at the repository root.
- **Git repositories**: Edit `ros2_for_unity_custom_messages.repos` to list remote repositories.

### Steps

* Clone this project.
    ```bash
    git clone git@github.com:RobotecAI/ros2-for-unity.git ~/ros2-for-unity
    ```
* You need to source your ROS2 installation before you proceed, for each new open terminal. It is convenient to include this command in your `~/.profile` file.
    ```bash
    # galactic
    . /opt/ros/galactic/setup.bash
    ```
* Enter `Ros2ForUnity` working directory.
    ```bash
    cd ~/ros2-for-unity
    ```
* Set up you custom messages in `ros2_for_unity_custom_messages.repos`
* Import necessary and custom messages repositories.
    ```bash
    ./pull_repositories.sh
    ```
    > *NOTE* `pull_repositories.sh` script doesn't update already existing repositories, you have to remove `src/ros2cs` folder to re-import new versions.
* Build `Ros2ForUnty`. You can build it in standalone or overlay mode.
    ```bash
    # standalone mode
    ./build.sh --standalone
    
    # overlay mode
    ./build.sh
    ```
    * You can add `--clean-install` flag to make sure your installation directory is cleaned before deploying.
* Unity Asset is ready to import into your Unity project. You can find it in `install/asset/` directory.
* (optionally) To create `.unitypackage` in `install/unity_package`
    ```bash
    create_unity_package.sh -u <your-path-to-unity-editor-executable>
    ```
    > *NOTE* Unity license is required. 

## OS-Specific usage remarks

For **standalone builds**, no ROS 2 environment sourcing is required. You can launch the Unity Editor directly from Unity Hub or GUI application launchers, or run built executables directly.

For **overlay builds**, you can run Unity Editor or App executable from GUI (clicking) or from terminal as long as ROS 2 is sourced in your environment. If sourcing system-wide, add your ROS 2 setup script (e.g. `source /opt/ros/jazzy/setup.bash`) to your `~/.profile` file.
Note that you need to re-log for changes in `~/.profile` to take place.
Running Unity Editor through Unity Hub is also supported for overlay builds as long as ROS 2 is properly sourced in the environment before launching Hub.

## Usage troubleshooting

**No ROS environment sourced. You need to source your ROS2 (..)**

* If you see `"No ROS environment sourced. You need to source your ROS2 (..)"` message in Unity3D Editor, it means your environment was not sourced properly. This could happen if you run Unity but it redirects to Hub and ignores your console environment variables (this behavior can depend on Unity3D version). In such case, run project directly with `-projectPath` or add ros2 sourcing to your `~/.profile` file (you need to re-log for it to take effect).

* Keep in mind that `UnityHub` stays in the background after its first launch and Unity Editor launch without `-projectPath` will redirect to it and the Hub will start Unity Editor. Since environment variables for the process are set on launch and inherited by child processes, your sourced ros2 environment in the console launching the Editor this way won't be applied. To make sure it applies (and to change between different ros2 distributions), make sure to terminate existing UnityHub process and run it with the correct ros2 distribution sourced.

**There are no errors but I can't see topics published by Ros2ForUnity**

* Make sure your dds config is correct.
* Sometimes ROS2 daemon brakes up when changing network interfaces or ROS2 version. Try to stop it forcefully (`pkill -9 _ros2_daemon`) and restart (`ros2 daemon start`).
