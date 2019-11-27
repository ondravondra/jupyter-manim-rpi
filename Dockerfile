FROM arm32v7/python:3.7-slim

RUN apt-get update && \
    apt-get install -y libzmq3-dev python3-zmq libcairo2-dev gcc ffmpeg && \
    pip3 install jupyter

ARG USER=jupyter
ARG UID=1000

RUN useradd -m -s /bin/bash -N -u ${UID} ${USER}

USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT jupyter notebook --ip=0.0.0.0
