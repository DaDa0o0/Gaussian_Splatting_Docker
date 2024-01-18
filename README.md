# 3D Gaussian Splatting Docker Setup

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
xhost +
docker run --runtime=nvidia --rm -it -v /home/da/extra/data:/data -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all --net host gaussian_splatting
```
### 6. Train
```
python3 train.py -s /data/bluerov_gaussian/Blyth -r 2 --ip 137.195.63.236 --port 6009 --save_iterations 1000 2000 3000 30000
```