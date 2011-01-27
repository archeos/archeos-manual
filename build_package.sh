#!/bin/sh
#
# Use this script to build the archeos-manual package
# Usage: sudo ./build-package.sh
#
if [ $1 ]; then
    echo "   ! Usage: sudo ./build-package.sh"
    exit 1
fi
echo -n "   * Check if we're root..."
if [ "$(id -u)" != "0" ]; then
    echo "\n   ! This script must be run by root or with sudo...exiting"
    exit 1
fi
echo "Done"
echo -n "   * Cleaning the /tmp directory..."
rm -rf /tmp/archeos-manual*
echo "Done"
echo -n "   * Retrieving information about version..."
MANUAL_VERSION=`grep "Version" archeos-manual/DEBIAN/control | cut -f 2 -d ' '`
echo $MANUAL_VERSION
echo -n "   * Moving the package outside of this repository..."
/bin/cp -ra archeos-manual/ /tmp/
echo "Done"
echo -n "   * Renaming the package..."
cd /tmp/
pack_name=archeos-manual_${MANUAL_VERSION}_all
mv archeos-manual/ $pack_name
echo "Done"
echo -n "   * Generating the md5sum file..."
cd $pack_name
find . -path ./DEBIAN -prune -o \! -type l | xargs file | grep -v 'directory' | cut -f 1 -d : | xargs md5sum > DEBIAN/md5sums
cd ..
echo "Done"
echo -n "   * Setting permissions..."
chown -R root:root $pack_name
echo "Done"
echo -n "   * Removing trailing slash (if present)..."
pack_name=$(echo "$pack_name" | sed -e "s/\/*$//")
echo "Done"
echo "   * And finally let's buld the package!'"
dpkg -b $pack_name $pack_name.deb

