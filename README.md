# 3D Gaussian SPlatting Docker Setup

## 1. Install Nvidia Driver
make sure you have the  nvidia driver is compatible with your cuda version 11.8

## 2. Install NVIDIA Container Toolkit
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

## 3. Change docker default runtime to nvidia
Edit/create the /etc/docker/daemon.json with content:
```
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```
## 4. Build docker image
```
DOCKER_BUILDKIT=0 docker build -t gaussian_splatting -f ./gaussian_splatting.Dockerfile --network host .
```
DOCKER_BUILDKIT=0 is needed to enable nvidia runtime during building docker


## 5. Run docker image
```
docker run --gpus all -it --rm  gaussian_splatting
```