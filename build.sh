#!/bin/bash

set -eu

readonly ROOT_PATH=$(cd $(dirname $0) && pwd)

## Get OS environment parameters.
if [ "$(uname -s)" = 'Darwin' ]; then
    # Mac OSX
    readonly ID='macos'
    readonly ARCH='x86_64'
    readonly IS_LINUX='false'

elif [ -e /etc/os-release ]; then
    . /etc/os-release
    readonly ARCH=`uname -p`
    readonly IS_LINUX='true'

else
    echo "Thank you for useing. But sorry, this platform is not supported yet."
    exit 1
fi

## Download libwebrtc (Compiled chromium WebRTC native APIs.)
readonly LOCAL_ENV_PATH=${ROOT_PATH}/local
readonly WEBRTC_VER=m78

mkdir -p ${LOCAL_ENV_PATH}/include
mkdir -p ${LOCAL_ENV_PATH}/src
cd ${LOCAL_ENV_PATH}/src

# Filename
if [ "${ID}" = 'macos' ]; then
    readonly WEBRTC_FILE="libwebrtc-78.0.3904.108-macosx-10.15.1.zip"
else
    readonly WEBRTC_FILE="libwebrtc-78.0.3904.108-ubuntu-18.04-x64.tar.gz"
fi

# Download and unarchive
if ! [ -e "${WEBRTC_FILE}" ]; then
    if [ "${ID}" = 'macos' ]; then
	curl -OL https://github.com/llamerada-jp/libwebrtc/releases/download/${WEBRTC_VER}/${WEBRTC_FILE}
	cd ${LOCAL_ENV_PATH}
	unzip -o src/${WEBRTC_FILE}
    else
	wget https://github.com/llamerada-jp/libwebrtc/releases/download/${WEBRTC_VER}/${WEBRTC_FILE}
	cd ${LOCAL_ENV_PATH}
	tar zxf src/${WEBRTC_FILE}
    fi
fi

## Build
# Change compiler to clang on linux
if [ "${IS_LINUX}" = 'true' ]; then
    export CC=cc
    export CXX=c++
fi

## Build client
BUILD_PATH=${ROOT_PATH}/client/build
mkdir -p ${BUILD_PATH}
# cd ${ROOT_PATH}
# git submodule init
# git submodule update
cd ${BUILD_PATH}
cmake -DLIBWEBRTC_PATH=${LOCAL_ENV_PATH} ..
make
cp client.out ${ROOT_PATH}


## Build server
BUILD_PATH=${ROOT_PATH}/server/build
mkdir -p ${BUILD_PATH}
# cd ${ROOT_PATH}
# git submodule init
# git submodule update
cd ${BUILD_PATH}
cmake -DLIBWEBRTC_PATH=${LOCAL_ENV_PATH} ..
make
cp server.out ${ROOT_PATH}