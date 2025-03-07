#!/bin/bash
# 描述：自动安装build-essential、OpenCV和Boost库
set -e

echo "更新软件包列表..."
sudo apt-get update

echo "安装build-essential..."
sudo apt-get install build-essential -y

echo "安装OpenCV库..."
sudo apt-get install libopencv-dev -y

echo "检查并添加Boost库PPA..."
if ! grep -q "^deb .*/mhier/libboost-latest" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:mhier/libboost-latest -y
    sudo apt-get update
fi

echo "安装Boost库..."
sudo apt install libboost1.81-all-dev -y

echo "验证安装版本..."
gcc -v
pkg-config --modversion opencv4
dpkg -s libboost1.81-all-dev | grep Version

echo "build-essential、OpenCV和Boost库安装并配置完毕。"
