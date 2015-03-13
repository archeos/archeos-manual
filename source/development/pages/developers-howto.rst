.. _developers-howto:

Developer's HowTos
==================

How to add new application into ArcheOS
---------------------------------------

To add a new application into ArcheOS you need to perform some modification into different repositories.
In general we follow these steps:

Checklist
^^^^^^^^^

1. The application must be packaged for Debian, preferring a source package format rather binary one.

2. The package must be available on official Debian repositories (``main``, ``contrib`` or ``non-free``) used by the target ArcheOS version; for example ArcheOS 5 Theodoric uses the **Debian Wheezy** repositories.
   Alternatively the package must be included into the official `ArcheOS repositories`_.

Add to the appropriate metapackage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Add the package name into the appropriate section into the `archeos-meta package`_. As example: if I want to add the ``tellervo`` package I will clone the **archeos-meta** repository, edit the **debian/control**, add the package under the ``dendrochronology`` section (``Package: archeos-dendrochronology``) and follow the usual procedure (commit, write changelog, build package, upload on ArcheOS repository). Refer to the :ref:`archeos-meta` build instructions for more information about.

Add entry to menu
^^^^^^^^^^^^^^^^^

1. If the package needs an entry on the custo ArcheOS menu, you need to manually insert an entry into is under the appropriate submenu. The :ref:`archeos-menu` page explains all the details on how it works.

2. Clone the `archeos-menu repository`_ and follow instructions here: :ref:`create-menu-entry`

3. If the package needs to be inserted into a new (not yet created) submenu be sure to follow also these instructions: :ref:`add-new-submenu`

4. Commit, build and upload the package to the official ArcheOS repositories as indicated in the :ref:`archeos-menu` page.

Write documentation
^^^^^^^^^^^^^^^^^^^

1. If needed write the appropriate documentation into the :ref:`archeos-manual`.
   Follow instructions on that page to build and upload the package to serve documentation to the ArcheOS users.

.. _ArcheOS repositories: http://apt.archeos.eu/
.. _archeos-meta package: https://github.com/archeos/archeos-meta
.. _archeos-menu repository: https://github.com/archeos/archeos-menu
