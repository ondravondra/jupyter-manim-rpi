#!/bin/bash

docker build . --target jupyter -t ondravondra/jupyter:arm32v7
docker build . --target jupyter-manim -t ondravondra/jupyter-manim:arm32v7
