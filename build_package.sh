#!/bin/sh
#
# Use this script to auto build the archeos-manual package.
# Usage: ./build_package.sh
#

# set -e

echo -n "   * Looking the control's version..."
VERSION=`grep "Version" "./archeos-manual/DEBIAN/control" | cut -f 2 -d ' '`
echo "Done"
echo -n "   * Copying the package into temp dir..."
/bin/cp -r ./archeos-manual/ /tmp/archeos-menu_${VERSION}_all
echo "Done"
echo -n "   * Removing trailing slash (if present)..."
pack_name=$(echo "/tmp/archeos-menu_${VERSION}_all" | sed -e "s/\/*$//")
cd $pack_name
echo "Done"
echo -n "   * Generating the md5sum file..."
find . -path ./DEBIAN -prune -o \! -type l | xargs file | grep -v 'directory' | cut -f 1 -d : | xargs md5sum > DEBIAN/md5sums
cd ..
echo "Done"
echo "   * And finally let's buld the package!'"
echo
fakeroot dpkg-deb --build $pack_name $pack_name.deb
echo "Done"
echo
lintian $pack_name.deb
