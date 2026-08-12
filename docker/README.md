# Ros2 For Unity - Docker Build

Docker Compose is used for building the ROS2 For Unity standalone asset in a clean, reproducible environment with all dependencies automatically handled.

## Building

To build the standalone asset using Docker Compose, run the following command from the repository root:

```bash
docker compose up --build
```

Upon successful completion, the compiled asset will be available on your host machine at:
```
install/asset/Ros2ForUnity/
```

## Custom Messages

You can include custom ROS 2 messages in the Docker build using either of the following methods:

- **Git-based**: Edit `ros2_for_unity_custom_messages.repos` at the repository root to specify repository URLs.
- **Local packages**: Drop ROS 2 message packages into the `custom_messages/` directory at the repository root.

## Notes

> [!NOTE]
> The old `build_image.sh` and `run_container.sh` scripts have been removed in favor of the unified Docker Compose workflow.