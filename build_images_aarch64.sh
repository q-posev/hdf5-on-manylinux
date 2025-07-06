#!/bin/bash

set -x
set -e

for tag in 2014_aarch64 2_28_aarch64
do
    echo "Building image on ${tag} platform"
    docker build -t "hdf5_1_12_on_${tag}:latest" -f "Dockerfile_${tag}" .
done

