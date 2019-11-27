ARG USER=jupyter
ARG UID=1000

FROM arm32v7/python:3.7-slim as jupyter
ARG USER
ARG UID

RUN apt-get update && \
    apt-get install -y libzmq3-dev gcc && \
    echo "[global]" > /etc/pip.conf && \
    echo "extra-index-url=https://www.piwheels.org/simple" >> /etc/pip.conf && \
    pip3 install jupyter

RUN useradd -m -s /bin/bash -N -u ${UID} ${USER}

USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT jupyter notebook --ip=0.0.0.0

FROM jupyter as jupyter-manim
ARG USER
ARG UID

USER root

# https://github.com/numpy/numpy/issues/11110#issuecomment-449852419
RUN apt-get install -y git ffmpeg libatlas-base-dev

RUN pip3 install git+https://github.com/3b1b/manim && \
    pip3 install git+https://github.com/krassowski/jupyter-manim

USER ${USER}
