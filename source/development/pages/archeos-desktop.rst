.. _archeos-desktop:

archeos-desktop package
=======================

.. include:: /global.rst

This page is intended to explain to other ArcheOS developers (or who's
interested in) the ArcheOS desktop metapackage.

Source
------

* `archeos-desktop on GitHub`_
* `git repository`_

Overview
--------

The ``archeos-desktop`` metapackage contains all packages/metapackages used to
build the whole ArcheOS system, including desktop environment, keyrings, menus
and so on.

You can check the control file for this package `here`_.

.. include:: ../build-instructions.include

The package
-----------

The package could be ideally installed on a vanilla **Debian wheezy** and
recreate the whole ArcheOS distribution.

At the moment is also used to switch between the GNOME and XFCE version of
ArcheOS, as it generates both the metapackages.

Is also used to ensure proper upgrades.

It is installed from ``live-build`` at build time.

HowTo
-----

.. note:: todo

.. _archeos-desktop on GitHub: https://github.com/archeos/archeos-desktop
.. _git repository: git@github.com:archeos/archeos-desktop.git
.. _here: https://github.com/archeos/archeos-desktop/blob/master/debian/control
