.. _archeos-meta:

archeos-meta package
====================

.. include:: /global.rst

This page is intended to explain to other ArcheOS developers (or who's
interested in) the ArcheOS metapackage.

Source
------

* `archeos-meta on GitHub`_
* `git repository`_

Overview
--------

.. include:: ../build-instructions.include

The package
-----------

The following main packages are built in ``archeos-meta``:

* ``archeos-system``
  It depends on all per-area metapackages (eg. ``archeos-gps``, ``archeos-cad``, ...). It can be used to install a fully functional ArcheOS installation on top of Debian (with the ``archeos-keyring``, ``archeos-desktop`` and ``archeos-manual`` too.).
  It is also used to ensure proper upgrades.

.. note:: todo

HowTo
-----

.. note:: todo

.. _archeos-meta on GitHub: https://github.com/archeos/archeos-meta
.. _git repository: git@github.com:archeos/archeos-meta.git
