#!/usr/bin/env sh

set -eu

if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    if aptitude -h > /dev/null 2>&1; then
        aptitude install autoconf -y
    else
        apt install autoconf -y
    fi
elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
    dnf install autoconf -y
fi

work_dir="$(mktemp --directory)"
cd "$work_dir"
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
make install
rm -rf "$work_dir"