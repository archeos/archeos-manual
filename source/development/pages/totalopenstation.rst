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

Packages
^^^^^^^^

* ``python-stdeb``
* ``git-buildpackage``
* ``cowbuilder`` (or ``pbuilder``)

Configuration files
^^^^^^^^^^^^^^^^^^^

.. note:: this section will go into some included file for every package

In ArcheOS we use some configuration file for ``git-buildpackage``, ``pbuilder`` and ``quilt`` to avoid typing every time the same commands. All instructions below assumes that you have the following configuration files in the home of the user who builds the packages (or similar):

* **~/.gbp.conf**

::

   [git-buildpackage]
   export-dir = ../build-area/
   tarball-dir = ../tarballs/
   builder = /usr/bin/git-pbuilder -sa
   # use 'DIST=wheezy git-pbuilder create' to create the archive
   # upgrade periodically with DIST=wheezy git-pbuilder update
   dist = wheezy
   pbuilder = True
   upstream-tree = master

* **~/.pbuilderrc**:

::

    MIRRORSITE=http://ftp.it.debian.org/debian/
    AUTO_DEBSIGN=yes

* **~/.quiltrc**

::

    QUILT_PATCHES=debian/patches
    QUILT_PUSH_ARGS="--color=auto"
    QUILT_DIFF_ARGS="--no-timestamps --no-index -p ab --color=auto"
    QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"
    QUILT_DIFF_OPTS='-p'

These files can be useful also for other debian packaging too.

Procedure
---------

Repository fork
^^^^^^^^^^^^^^^

The upstream repository for this package is https://github.com/steko/totalopenstation
We need to fork it into archeos/totalopenstation (https://github.com/archeos/totalopenstation) using the GitHub web interface so we can push our modifications.

Then we will clone it at tag ``0.3`` that is the latest stable release we are interested in.

* ``git clone -b 0.3 git@github.com:archeos/totalopenstation.git``

Creation and first import
^^^^^^^^^^^^^^^^^^^^^^^^^

* Enter the ``totalopenstation`` folder
* Create a ``master`` branch from the ``0.3`` tag: ``git branch master 0.3``
* Switch to the ``master`` branch: ``git checkout master``

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
    * Rename the binary package from ``python-totalopenstation`` to ``totalopenstation``
    * Move the **Maintainer** to **X-Original-Maintainer:**
    * Change **Maintainer:** to you
    * Remove ``python-all`` and use ``python`` instead in **Build-Depends:**
    * Change ``debhelper`` from ``9`` to ``8`` into **Build-Depends:**
    * Change **Standard-Version:** to ``3.9.3``
    * Remove formatting from description

4. **rules**
    * Remove ``export PYBUILD_NAME`` line
    * Remove ``--buildsystem=pybuild``
    * Add ``export DH_OPTIONS`` and ``INSTDIR=debian/tmp`` at the beginning
    * Add these overrides:

::

    override_dh_auto_install:
        dh_auto_install --destdir=$(INSTDIR)

        override_dh_auto_clean:

We can now commit the changes with ``git commit -a -m 'Debianization'``.

5. **totalopenstation.install**

::

    usr/bin/*.py usr/share/totalopenstation/
    usr/lib/
    totalopenstation.desktop usr/share/applications/
    totalopenstation.svg usr/share/icons/

6. **totalopenstation.links**

::

    usr/share/totalopenstation/totalopenstation-cli-parser.py usr/bin/totalopenstation-cli-parser
    usr/share/totalopenstation/totalopenstation-cli-connector.py usr/bin/totalopenstation-cli-connector
    usr/share/totalopenstation/totalopenstation-gui.py usr/bin/totalopenstation-gui

7. **totalopenstation.docs**

::

    README.txt
    docs/

Icons and desktop file
^^^^^^^^^^^^^^^^^^^^^^

In the development version of totalopenstation there will be an icon and a .desktop file that will go into **/usr/share/{applications,icons}** but in the ``0.3`` tag we need to add these to the package and patch it using **quilt**.

.. note:: **quilt** is a tool used in debian packaging to avoid invasive modifications to the upstream package. Each modification will be "transformed" into a patch that will go into the **debian/patches** folder. In debian packaging the **debian/** folder is the only folder that will be added to the original software.

* ``quilt new icon-and-files.patch``
* ``quilt add totalopenstation.desktop totalopenstation.svg``

Now let's copy the ``totalopenstation.destkop`` and ``totalopenstation.svg`` files into the package main folder. The desktop file could be something like this:

::

    [Desktop Entry]
    Version=1.0
    Type=Application
    Terminal=false
    Exec=totalopenstation-gui
    Icon=totalopenstation
    Name=Total Open Station
    Comment=Download and export survey data from your total station]

The icon needs to be copied from some other place...

* When all files are copied you can actually build patches with ``quilt refresh``
* Unapply all patches to do a "clean" package with ``quilt pop -a``
* Ignore the **.pc** folder with ``echo '.pc' >> .gitignore``
* ``git add .gitignore debian/patches``
* ``git commit -m 'patches'``

The package can be now build with:

* ``mkdir ../build-area/``
* ``git-buildpackage``

.. note:: The **build-area** folder can be also specified as default into the **~/.gbp.conf** file so we don't need to pass ``--git-export-dir=`` option every time.

If the build is successful we can now add an entry to the changelog updating the version to ``0.3archeos-1``.

* ``git dch -R``

And let git-buildpackage tag the repository for us with:

* ``git-buildpackage --git-tag-only``

After the compilation we will find all files we need into the **../build-area/** folder, including debs and archives. We will upload to the ``reprepro`` repository later.

Push all our stuff to the remote repository with:

* ``git push``
* ``git push --tags``

Daily packaging
^^^^^^^^^^^^^^^

Once the package has been built the first time we only need to follow the usual ArcheOS/git-buildpackage workflow to build it: if we check tags (``git tag --list``) we will see that a new tag called **debian/0.3.1-archeos1** has been automatically created for us.

* ``git-buildpackage``

To rebuild the totalopenstation package.

.. _totalopenstation on GitHub: https://github.com/steko/totalopenstation
.. _totalopenstation ArcheOS repository: https://github.com:archeos/totalopenstation.git
.. _quilt: https://www.debian.org/doc/manuals/maint-guide/modify.en.html#quiltrc
