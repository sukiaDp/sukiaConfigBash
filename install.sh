#!/bin/bash

# 描述：自动切换PPA源并安装GCC 13、OpenCV和Boost库，然后切换至GCC 13

set -e

echo "更新软件包列表..."
sudo apt-get update

echo "检查并添加Ubuntu Toolchain测试PPA..."
if ! grep -q "^deb .*/ubuntu-toolchain-r/test" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get update
fi

echo "安装GCC 13和G++ 13..."
sudo apt-get install gcc-13 g++-13 -y

echo "配置GCC和G++为默认版本..."
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 60 --slave /usr/bin/g++ g++ /usr/bin/g++-13

echo "切换默认GCC版本至GCC 13..."
sudo update-alternatives --set gcc /usr/bin/gcc-13

echo "安装OpenCV库..."
sudo apt-get install libopencv-dev -y

echo "检查并添加Boost库PPA..."
if ! grep -q "^deb .*/mhier/libboost-latest" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:mhier/libboost-latest -y
    sudo apt-get update
fi

echo "安装Boost库..."
sudo apt install libboost1.81-dev -y

echo "验证安装版本..."
gcc -v
pkg-config --modversion opencv4
dpkg -s libboost-all-dev | grep Version

echo "GCC 13、OpenCV和Boost库安装并配置完毕。"
