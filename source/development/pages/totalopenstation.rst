.. _totalopenstation:

TotalOpenStation package
========================

.. include:: /global.rst

This package is intended to describe the ArcheOS modification and packaging to the TotalOpenStation (tops) application.

Source
------

* `totalopenstation on GitHub`_
* `totalopenstation ArcheOS repository`_

Requirements
------------

* ``python-stdeb`` package

Procedure
---------

The **master** branch will be used to build the package, while the **upstream** branch will contain the original code

Creation and first import
^^^^^^^^^^^^^^^^^^^^^^^^^

1. First clone the upstream repository: ``git clone https://github.com/steko/totalopenstation``
2. Create the archive: ``tar cvzf totalopenstation-0.3.1pre.tar.gz totalopenstation --exclude-vcs``
3. ``cd totalopenstation``
4. Create a **upstream** branch: ``git checkout --orphan upstream``
5. Commit all inside upstream: ``git commit --allow-empty -m 'Upstream'``
6. Back to master: ``git checkout -f master``
7. Import the tarball: ``git-import-orig --pristine-tar ../totalopenstation-0.3.1pre.tar.gz``

Now there will be 3 branches:

::
    * master
      pristine-tar
      upstream

Create the debian folder:

1. ``python setup.py --command-packages=stdeb.command debianize``

Enter the **debian/** dir and change:

1. **changelog**
    * Maintainer
    * Message to ``Initial release.``
    * distribution from ``unstable`` to ``theodoric``

2. **compat**
    * from ``9`` to ``8``
3. **control**
    * Move the **Maintainer** to **X-Original-Maintainer:**
    * Change **Maintainer:** to you
    * Remove ``python-all`` and use ``python`` instead in **Build-Depends:**
    * Change ``debhelper`` from ``9`` to ``8`` into **Build-Depends:**
    * Change **Standard-Version:** to ``3.9.3``
    * Remove formatting from description
4. **rules**
    * Remove ``export PYBUILD_NAME`` line
    * Remove ``--buildsystem=pybuild``

The package can be now build with:

* ``git-buildpackage``

If all went fine a new entry inside **changelog** can be created with: ``git dch -R``
The entry must be placed above the existing one with a new version number like `0.3.1-archeos1`

.. _totalopenstation on GitHub: https://github.com/steko/totalopenstation
.. _totalopenstation ArcheOS repository: todo

