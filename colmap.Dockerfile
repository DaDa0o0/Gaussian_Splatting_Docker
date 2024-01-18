FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# RUN 
RUN apt update && apt install vim -y
SHELL ["/bin/bash", "-c"]

# colmap
RUN apt-get install git cmake ninja-build build-essential libboost-program-options-dev libboost-filesystem-dev libboost-graph-dev libboost-system-dev libeigen3-dev libflann-dev libfreeimage-dev libmetis-dev libgoogle-glog-dev libgtest-dev libsqlite3-dev libglew-dev qtbase5-dev libqt5opengl5-dev libcgal-dev libceres-dev gcc-10 g++-10 -y
ENV CC gcc-10
ENV CXX g++-10
ENV CUDAHOSTCXX /usr/bin/g++-10
WORKDIR /
RUN git clone https://github.com/colmap/colmap.git
WORKDIR /colmap/build
RUN cmake .. -D CMAKE_CUDA_ARCHITECTURES=80 -GNinja && ninja && ninja install

ENTRYPOINT ["bash"]
# ENTRYPOINT ["bash","/run_dvl2_blue.sh"]