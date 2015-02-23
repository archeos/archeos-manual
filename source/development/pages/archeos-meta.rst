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
  It depends on all per-area metapackages (eg. ``archeos-gps``, ``archeos-cad``,
  ...). It is used to ensure proper upgrades.
* All other ``archeos-*`` packages are intended to collect all ArcheOS-specific
  softwares, grouping them in a easy, per-area format.

HowTo
-----

Add a new application into ArcheOS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. If not done already, fork the ``archeos-meta`` repository (see above).
2. Edit the **debian/control** file and add the desired package into the
   appropriate section (metapackage) as the others.
3. Ensure that:
    * The package is stable and well tested on ArcheOS.
    * The package is available throught the official Debian repositories or the ArcheOS APT repositories.
    * The software license is compatible with ArcheOS (or :ref:`contact-developers` if you are not confident about)
4. Send us a pull request and if possible we'll insert the new software into the
   metapackage.
5. Once the request is approved the ArcheOS developers will build the
   ``archeos-meta`` package and upload the new metapackage on the official
   ArcheOS APT repositories.

.. _archeos-meta on GitHub: https://github.com/archeos/archeos-meta
.. _git repository: git@github.com:archeos/archeos-meta.git
