.. _build-iso:

How to build the ArcheOS ISO image
==================================

Intro
-----

ArcheOS developers uses `live-build`_ software to built the ArcheOS ISO image
that will be distributed to the users.
This allows us to create a versatile and shared development environment and
forces us to comply to some Debian standards too.

Requirements
------------

All the following software must be installed and configure before proceeding
with the build.
All the packages listed below can be downloaded and installed on a Debian/Ubuntu
box with APT or similar.

* A working Debian (wheezy or higher) or Ubuntu (13.04+) system.
* Grants to run `sudo` or became superuser.
* At least 15GB of free space (can be freed when all is complete).
  ArcheOS build uses so much space because it needs to download every single
  package in a cache directory and then build the ISO.
* A working internet connection (to download debian packages).
* ``live-build`` (ArcheOS build configuration uses the 3.X version of
  live-build).
* _`apt-cacher-ng` is an APT proxy that speeds up the debian packages
  download (not the first time). Is not strictly needed but is very useful if
  you want to try and build with different options. The ArcheOS live-build
  cconfiguration requires this to be present, see instructions below on how to
  configure.

Optional requirements
^^^^^^^^^^^^^^^^^^^^^

* VirtualBox or Qemu or other virtualization tool to test the ISO before
  burning.

Configure apt-cacher-ng
^^^^^^^^^^^^^^^^^^^^^^^
Some users complains about apt-cacher-ng errors:
 
``(403  Configuration  error (confusing proxy mode) or prohibited port (see AllowUserPorts)  [IP: 127.0.0.1 3142])``

To solve this edit (with sudo or as root) the file **/etc/apt-cacher-ng/acng.conf** and replace the line:

::

   # AllowUserPorts: 80

with:

::

   AllowUserPorts: 0

and restart apt-cacher-ng with ``sudo service apt-cacher-ng restart``
 
Instructions to build ArcheOS iso
---------------------------------

Follows step-by-step instructions on how to build the ISO on Debian or Ubuntu

1. Clone the git repository with ``git clone git://github.com/archeos/ArcheOS.git``
2. Enter the ArcheOS/debian-live directory ``cd ArcheOS/debian-live/``
3. Launch the config command ``sudo lb clean && lb config``

.. warning:: On Ubuntu box you have to use the ``sudo lb clean && lb config --mode debian``

4. If no errors occured during the configuration launch the build command ``sudo lb build``

.. note:: You have to wait a long time until the build is completed...

5. At the end of the process, if all is gone fine you should have a 
   **binary-hybrid.iso** file in your working directory. Burn it to a DVD
   or boot up with the virtualization software (see above)
6. CLEAN THE ENVIRONMENT  with ``sudo lb clean --purge``


.. warning:: Remember to run ``sudo lb clean --purge`` BEFORE launch again lb
             config to reset the original status

HowTo
-----

Include different (optional) packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the package is present in the Debian/ArcheOS APT repositories
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

1. Ensure that the package is available either in the Debian repositories (the
   same used by the ArcheOS version) or in the ArcheOS APT repositories.
2. Edit the **ArcheOS/debian-live/config/package-lists/archeos-core.list.chroot** file and add the desired package name at the end of file.
3. Optionally you can create an additional file similar to the **archeos-core.list.chroot** and list the desired package there. Note that the file MUST have the    ``.list.chroot`` suffix.
3. Build as stated before.

If the package is not available on APT repositories
"""""""""""""""""""""""""""""""""""""""""""""""""""

1. Create (if not already present) the **ArcheOS/debian-live/config/packages.chroot/**
2. Copy the binary debian packages to install into the folder.
3. Build as stated before.

Refer to the `live-manual`_ section about that for more information.

Build ArcheOS with different architecture
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The default ArcheOS architecture is the same as the Linux machine where the ISO is built. 
This means that if you are on a amd64 pc you will build an amd64 version of ArcheOS.

To change this you need to pass the ``--architectures`` option to ``lb config`` at build time. For example, if you are on a **amd64** Linux box you could build a i386 ArcheOS with:

1. ``sudo lb clean --purge``
2. ``lb config --architecture i386``
3. ``sudo lb build``

Obviously is not possible to build a **amd64** version of ArcheOS on a **i386** host.

.. warning:: some packages are still not migrated to the "correct" format (are still in form of binary ``.deb`` packages), so they could not be available to the desired architecture.



.. _live-build: http://live.debian.net/devel/live-build/
.. _apt-cacher-ng: http://live.debian.net/devel/live-build/
.. _live-manual: http://live.debian.net/manual/3.x/html/live-manual.en.html#430
