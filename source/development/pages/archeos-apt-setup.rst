.. _apt-setup:

archeos-apt-setup package
=========================

.. include:: /global.rst

Source
------

* `archeos-apt-setup on GitHub`_
* `git repository`_

Overview
--------

This source package generates the following udebs:

* ``apt-cdrom-setup``
* ``apt-mirror-setup``
* ``apt-setup-udeb``

.. include:: ../build-instructions.include

The package
-----------

The package is patched to use the preseed directive ``d-i apt-setup/disable-cdrom-entries boolean true`` into **config/debian-installer/preseed.cfg** that eliminates the cdrom entries into the installed ArcheOS **/etc/apt/sources.list** file.

The package needs to be periodically merged with the `upstream Debian version`_ and the patch checked.

The patch has been created by the `Kali Linux team`_ and the ArcheOS package is shamelessly copied and renamed.

The future
----------

In the future the udeb packages should not be put manually into the **config/packages.binary** folder (also because they are binary files into a GIT repos...) 
and a dedicated mirror should be created to include such packages needed during bootstrap/build phases.

In the future we also hope that the patch will be integrated into upstream package.

Howto
-----

Update with Debian upstream version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: todo


.. _archeos-apt-setup on GitHub: https://github.com/archeos/archeos-apt-setup
.. _git repository: git@github.com:archeos/archeos-apt-setup.git
.. _upstream Debian version: http://anonscm.debian.org/gitweb/?p=d-i/apt-setup.git
.. _Kali Linux team: http://git.kali.org/gitweb/?p=packages/apt-setup.git;a=summary
