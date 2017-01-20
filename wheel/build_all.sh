#!/usr/bin/env bash
set -e

mkdir -p whl/cu75
mkdir -p whl/cu80

BUILD_VERSION=0.1.6
BUILD_NUMBER=20

~/switch_cuda_version.sh 7.5

./build_wheel.sh 2 7.5 $BUILD_VERSION $BUILD_NUMBER
./build_wheel.sh 3 7.5 $BUILD_VERSION $BUILD_NUMBER

~/switch_cuda_version.sh 8.0

./build_wheel.sh 2 8.0 $BUILD_VERSION $BUILD_NUMBER
./build_wheel.sh 3 8.0 $BUILD_VERSION $BUILD_NUMBER

ls whl/cu75/ | xargs -I {} aws s3 cp whl/cu75/{} s3://pytorch/whl/cu75/ --acl public-read
ls whl/cu80/ | xargs -I {} aws s3 cp whl/cu80/{} s3://pytorch/whl/cu80/ --acl public-read