# ROS 2 For Unity — Docker Build Guide

Docker Compose is used for building the ROS2 For Unity standalone asset in a clean, reproducible environment with all dependencies (ROS 2 Jazzy, .NET 8 SDK, `libfmt`, `libtinyxml2`, `patchelf`) automatically handled.

---

## Workflow Options

### Option A: One-Command Automated Build (Recommended for Teams)

To build the complete standalone asset automatically in one command, run:

```bash
docker compose up --build
```

When finished, your Unity asset will be ready at:
```text
install/asset/Ros2ForUnity/
```
Simply copy this folder into your Unity project's `Assets/` directory.

---

### Option B: Interactive Shell Mode (Recommended for Debugging & Step-by-Step Execution)

If you prefer to enter the container interactively to run build steps manually, inspect logs, or debug:

1. **Start an interactive bash shell inside the container:**
   ```bash
   docker compose run --rm builder bash
   ```

2. **Run the setup and build commands step-by-step inside the container:**
   ```bash
   # Pull sub-repositories
   ./pull_repositories.sh

   # Build standalone asset
   ./build.sh --standalone
   ```

3. **Exit the container:**
   ```bash
   exit
   ```

---

## Adding Custom Messages

ROS2 For Unity automatically generates C# wrappers (`.dll` assemblies) for standard and custom ROS 2 messages. You can include custom messages using either of these methods:

### Method 1: Local Directory (Easiest for local development)
Drop your ROS 2 message package folder(s) directly into the `custom_messages/` directory at the repository root:

```text
ros2-for-unity/
├── custom_messages/             <-- Single folder for custom messages
│   └── my_custom_msgs/          <-- Your ROS 2 package
│       ├── CMakeLists.txt
│       ├── package.xml
│       └── msg/
│           └── MyMessage.msg
├── docker-compose.yml
└── ...
```

### Method 2: Git Repositories (For shared team packages)
Edit `ros2_for_unity_custom_messages.repos` at the repository root:

```yaml
repositories:
  src/ros2cs/custom_messages/my_custom_msgs:
    type: git
    url: https://github.com/my-org/my_custom_msgs.git
    version: main
```

---

## Notes & Migration

> [!NOTE]
> The legacy scripts (`build_image.sh` and `run_container.sh`) have been replaced by `docker-compose.yml`. Use `docker compose up` or `docker compose run --rm builder bash` instead.