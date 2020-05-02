#!/usr/bin/env sh


sudo apt-get update && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        gcc \
        libc6-dev \
        make \
        pkg-config

set -ex

dist=$1
curr_dir=$(pwd)
work_dir=$(mktemp --directory)
cd "$work_dir"

git clone https://github.com/universal-ctags/ctags.git
cd ctags

./autogen.sh

if [ "$dist" = "" ]; then
    ./configure
else
    ./configure --prefix="$dist"
fi

make -j2
sudo make install

cd "$curr_dir"
rm -rf "$work_dir"


