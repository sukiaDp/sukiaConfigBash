# 脚本名称：install_gcc_opencv_boost.sh
# 描述：自动切换PPA源并安装GCC 13、OpenCV和Boost库，然后切换至GCC 13

set -e

echo "更新软件包列表..."
sudo apt-get update

echo "添加Ubuntu Toolchain测试PPA..."
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y

echo "更新软件包列表..."
sudo apt-get update

echo "安装GCC 13和G++ 13..."
sudo apt-get install gcc-13 g++-13 -y

echo "使用update-alternatives配置GCC和G++..."
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 60 --slave /usr/bin/g++ g++ /usr/bin/g++-13

echo "切换默认GCC版本至GCC 13..."
sudo update-alternatives --config gcc

echo "验证GCC版本..."
gcc -v

echo "添加OpenCV PPA..."
sudo add-apt-repository ppa:opencv/opencv -y

echo "更新软件包列表..."
sudo apt-get update

echo "安装OpenCV库..."
sudo apt-get install libopencv-dev -y

echo "添加Boost库PPA..."
sudo add-apt-repository ppa:mhier/libboost-latest -y

echo "更新软件包列表..."
sudo apt-get update

echo "安装Boost库..."
sudo apt-get install libboost-all-dev -y

echo "验证安装版本..."
gcc -v
pkg-config --modversion opencv4
dpkg -s libboost-all-dev | grep Version

echo "GCC 13、OpenCV和Boost库安装并配置完毕。"
