#!/bin/bash

# Install Pacman in Git Bash (Git for Windows SDK)
# From here on out, you can use Pacman to install packages in Git Bash similar to how you would on Arch Linux.
# Package names will differ, i recommend checking https://packages.msys2.org/base for available packages.

cd /tmp
git clone -n --depth=1 --filter=blob:none https://github.com/git-for-windows/git-sdk-64.git
cd git-sdk-64
git sparse-checkout set --no-cone etc/pacman.d etc/pacman.conf usr/bin/pacman.exe var/lib/pacman
git checkout
cp -rf ./etc ./usr ./var /
pacman --noconfirm -Syy pacman 2>/dev/null
cd ..
rm -rf git-sdk-64
