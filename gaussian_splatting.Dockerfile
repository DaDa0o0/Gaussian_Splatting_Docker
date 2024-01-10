FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# RUN 
RUN apt update && apt install vim -y
SHELL ["/bin/bash", "-c"]

# conda installation
# RUN apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6  -y
# WORKDIR /
# RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
# # RUN bash /Anaconda3-2023.09-0-Linux-x86_64.sh
# RUN bash /Anaconda3-2023.09-0-Linux-x86_64.sh -b
# ENV PATH /root/anaconda3/bin:$PATH
# RUN conda update conda
# RUN conda update anaconda
# RUN conda update --all

# gaussian-splatting
WORKDIR /
RUN apt-get install curl git python3 python3-pip -y
RUN pip install torch==2.0.0 torchvision==0.15.1 torchaudio==2.0.1 --index-url https://download.pytorch.org/whl/cu118
RUN pip install plyfile==0.8.1 tqdm
RUN apt-get install ninja-build
RUN git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
WORKDIR /gaussian-splatting
RUN pip install ./submodules/diff-gaussian-rasterization
RUN pip install ./submodules/simple-knn

ENTRYPOINT ["bash"]
# ENTRYPOINT ["bash","/run_dvl2_blue.sh"]