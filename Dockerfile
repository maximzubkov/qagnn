FROM nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
                    build-essential \
                    ca-certificates \
                    wget \
                    curl \
                    unzip \
                    git \
                    ssh \
                    sudo \
                    vim

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda init bash

COPY . ./qagnn
WORKDIR /qagnn

RUN conda create --name env python=3.7
RUN conda config --add channels conda-forge
RUN conda config --add channels pytorch

RUN /root/miniconda3/envs/env/bin/pip install torch==1.8.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
RUN /root/miniconda3/envs/env/bin/pip install transformers==3.4.0
RUN /root/miniconda3/envs/env/bin/pip install nltk spacy==2.1.6
RUN /root/miniconda3/envs/env/bin/python -m spacy download en

RUN /root/miniconda3/envs/env/bin/pip install torch-scatter==2.0.7 -f https://pytorch-geometric.com/whl/torch-1.8.0+cu101.html
RUN /root/miniconda3/envs/env/bin/pip install torch-sparse==0.6.9 -f https://pytorch-geometric.com/whl/torch-1.8.0+cu101.html
RUN /root/miniconda3/envs/env/bin/pip install torch-geometric==1.7.0 -f https://pytorch-geometric.com/whl/torch-1.8.0+cu101.html