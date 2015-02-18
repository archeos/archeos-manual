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

Notes
-----

.. _live-build: http://live.debian.net/devel/live-build/
.. _apt-cacher-ng: http://live.debian.net/devel/live-build/
