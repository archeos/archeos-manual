#!/bin/sh
#
# Use this script to auto build the archeos-manual
# package.
# Usage: sudo ./build_package.sh archeos-manual_package/
#

set -e

echo "   * Looking the control's version..."
VERSION = grep "Version" $1/DEBIAN/control | cut -f 2 -d ' ' 
echo "   * Copying the package into temp dir..."
/bin/cp -r $1 /tmp/archeos-menu_$(VERSION)_all
cd /tmp/
echo "   * Setting permissions..."
sudo chown -R root:root archeos-menu*
echo "   * Removing trailing slash (if present)..."
pack_name=$(echo "$2" | sed -e "s/\/*$//")
cd $pack_name
echo "   * Finding and stripping binary files..."
#    find . | xargs file | grep "executable" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded
echo "   * Finding and stripping libraries..."
#    find . | xargs file | grep "shared object" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 
echo "   * Generating the md5sum file..."
find . -path ./DEBIAN -prune -o \! -type l | xargs file | grep -v 'directory' | cut -f 1 -d : | xargs md5sum > DEBIAN/md5sums
cd ..
echo "   * And finally let's buld the package!'"
dpkg -b $pack_name $pack_name.deb
echo
echo
lintian $pack_name.deb
