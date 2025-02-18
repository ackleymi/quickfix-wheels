rm -rf quickfix
git clone --depth 1 https://github.com/quickfix/quickfix.git
rm -rf quickfix/.git

apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y python3-dev python3-pip python3-venv libtool  libssl-dev swig
apt clean
pkg-config --libs openssl

yum update -y
yum install openssl-devel swig -y
pkg-config --libs openssl


cd quickfix
./bootstrap
./configure --with-python3 --with-postgresql --with-mysql && make 
cd ..

rm -rf quickfix-python/C++
rm -rf quickfix-python/spec
rm -rf quickfix-python/quickfix*.py
rm -rf quickfix-python/doc
rm -rf quickfix-python/LICENSE

mkdir quickfix-python/C++
mkdir quickfix-python/spec

cp quickfix/LICENSE quickfix-python

cp quickfix/src/python3/*.py quickfix-python
cp quickfix/src/C++/*.h quickfix-python/C++
cp quickfix/src/C++/*.hpp quickfix-python/C++
cp quickfix/src/C++/*.cpp quickfix-python/C++
cp -R quickfix/src/C++/double-conversion quickfix-python/C++
cp quickfix/src/python3/QuickfixPython.cpp quickfix-python/C++
cp quickfix/src/python3/QuickfixPython.h quickfix-python/C++

cp quickfix/spec/FIX*.xml quickfix-python/spec

touch quickfix-python/C++/config.h
touch quickfix-python/C++/config_windows.h
touch quickfix-python/C++/Allocator.h
rm -f quickfix-python/C++/stdafx.*
cp -R quickfix/src/swig "quickfix-python/C++"