.. _new-archeos-release:

New ArcheOS Release
===================

This page describes all steps necessary to release a new ArcheOS version. Take it as a list of reminder tasks for the next upgrade.

.. warning:: In this page I use the following convention: **theodoric** is the *old* distribution, **hypatia** is the *new* distribution, **wheezy** is the old Debian version theodoric was based on while **jessie** is the new one. Obviously replace these terms while you follow the instructions.

0. Prerequisites
----------------

* A codename for the new release
* An updated build toolchain installed onto a Debian distribution the same version the target ArcheOS release will be (eg. *jessie*) (see below)
* Some artwork to include into the release (for GRUB/Syslinux/XFCE) 

1. Create new reprepro distribution
-----------------------------------

On **farpoint**:

* Backup **/srv/reprepro/** folder: ``sudo cp -a /srv/reprepro reprepro_backup.$(date +%s)``
* Edit **/srv/reprepro/conf/distributions**

  * Comment the ``oldstable`` distribution entry (**Caesar**)
  * Adapt ``Label:``, ``Codename`` and ``Description`` field of **archeos-next** to reflect the new distribution (**hypatia**), specifically:

    * Remove ``Testing`` from ``Label:`` and ``Description:`` and change it to ``Hypatia``

  * Create a new **archeos-next** distribution similar to the old value for stable. Remember to increment the ``Version:`` field
  * The **theodoric** distribution ``Suite:`` is still ``stable``: it will changed when **hypatia** will be released and become stable
  * **hypatia** ``Suite:`` is ``testing`` for the moment
  * **archeos-next** ``Suite:`` is ``unstable`` for the moment
  * Save and quit

* Run ``reprepro -V -b /srv/reprepro/ --delete clearvanished`` to get rid of old distribution packages
* Run ``reprepro -V -b /srv/reprepro export theodoric``
* Run ``reprepro -V -b /srv/reprepro export hypatia``
* Run ``reprepro -V -b /srv/reprepro export archeos-next``

If you have worked until now on **archeos-next** for the next release and consider the packages into this distribution stable enough to go into **hypatia** you can import them all:

* ``reprepro -V -b /srv/reprepro copymatched hypatia archeos-next \*`` (see ``reprepro`` man page)

Alternatively you can copy binary and source packages individually from **archeos-next** to **hypatia**:

* ``reprepro -V -b /srv/reprepro copy hypatia archeos-next package-name``
* ``reprepro -V -b /srv/reprepro copysrc hypatia archeos-next package-name``

At the end you can list packages into **hypatia** to see what has been imported:

* ``reprepro -V -b /srv/reprepro list hypatia``

You can test the new distribution on any Debian/ArcheOS client replacing ``theodoric`` with ``hypatia`` in ``sources.list`` file and running ``apt-get update``

2. Update build toolchain
-------------------------

Your configuration files for ``git-buildpackage`` and ``pbuilder`` should have the *old* Debian version (eg. *wheezy*). You have to change it to the new one (eg. *Jessie*) and regenerate the cowbuilder/pbuilder archives. 

Refer to the :ref:`developers-toolchain` page for more information on this topic.

Some examples:

* **~/.gbp.conf**:

::

   [git-buildpackage]
   export-dir = ../build-area/
   tarball-dir = ../tarballs/
   builder = /usr/bin/git-pbuilder -sa
   # use 'DIST=jessie git-pbuilder create' to create the archive
   # upgrade periodically with DIST=jessie git-pbuilder update
   dist = jessie
   pbuilder = True
   upstream-tree = master

* Create the new base images used to build packages: ``DIST=jessie git-pbuilder create``
* Use the last `live-build`_ package available for the target distribution. For example in Debian *Jessie* the live-build package is version 4. Probably you have to check that the current configuration for live-build (see `ArcheOS repository`_) is compatible with the new version. 

3. Re-packaging tasks
---------------------

This is the most long and challenging task. Roughly the workflow is:

* Clone the ``archeos-meta``, ``archeos-keyring``, ``archeos-manual`` and ``archeos-menu`` repositories
* Create a branch **hypatia** from **archeos-next** branch (or from **master** if you want) on each repository and change the version number to the new one (eg. from 5 to 6). Change the codename too.
* Repackage all these metapackages using the new build toolchain and upload them to **hypatia** on reprepro
* Install a plain Debian, the version must be the same of the new ArcheOS version (**jessie**). You can use `Vagrant`_ for this task.
* Setup the new ArcheOS repository (**hypatia**) into **/etc/apt/sources.list.d/archeos.list** (``echo 'deb http://apt.archeos.eu/ hypatia main contrib non-free' > /etc/apt/sources.list.d/archeos.list``)
* Try to install the ``archeos-system`` metapackage and check which packages have broken dependencies
* If a metapackage cannot be installed you have to find which package is broken inside the metapackage, then you have some choices:

  * Re-package the broken package to use correct library version (if the package cannot be installed due to library dependency problem). You should also check if the upstream code for that software is updated against our version and in case update it. Import then into **hypatia**
  * Migrate the package on **reprepro** from the old distribution to the new one. This is useful for metapackages that fails to install due to the lack of some package in the new repository and there is no new version for that software. In this case you can copy package from one distribution to another with the following commands: 

    * ``reprepro -v -b /srv/reprepro copy hypatia theodoric package-name``
    * ``reprepro -v -b /srv/reprepro copysrc hypatia theodoric package-name``

  * Remove the missing dependency from the ``archeos-meta`` metapackage. This is the case when the ArcheOS community decides the software is not needed anymore. In this case you can safely remove the dependency from the ``archeos-meta`` control file, re-package it and upload it again in the **hypatia** distribution.
  * Decide that the package is needed but at the moment it cannot be repackaged for variuos reasons (such as no developers to work at). This is an useful option if you want to test the new distribution temporary without this package. In this case you can remove the dependency from the ``archeos-meta`` control file and re-package and upload it to the new distribution. **Keep track** of the missing package some way, like an issue on the `GitHub repository for archeos-meta`_ or some wiki page.

4. Try to build the ISO
-----------------------

When all required packages are assuming to work in the new distribution is time to try to build an ISO with **live-build** and see what happens.

* Clone the `ArcheOS repository`_
* Create a new branch to perform all tests without impacting **master** branch ``git checkout -B hypatia``
* Change all the occurrencies for **theodoric** or **wheezy**, specifically:

  * The **debian/live/auto/config** file
  * The **debian-live/config/package-lists/archeos-core.list.chroot**
  * The files into **debian-live/config/archives/** folder

5. Merge all changes into master
--------------------------------

Once you have tested that all works with the new distribution you can decide the release day and merge all chages you've done in packages and **live-build** configuration into the respective **master** branches. This way the repository will tracks by default the updated version.

**For each** of the packages you've created the **hypatia** branch:

* ``git checkout master``
* ``git checkout -B theodoric`` (we create a new branch from the *old* master to keep track of the old version of this package)
* ``git checkout master`` (come back to master branch)
* ``git merge hypatia`` this will merge all our new changes to the master branch
* Check all is fine with the package (try to build it)
* Upload the package to reprepro **hypatia**
* ``git branch -d hypatia`` (we remove the **hypatia** branch now that is merged into master)
* ``git push``

The ArcheOS repository too needs to be merged into the **master** branch using the same procedure.

6. Point the reprepro's stable distribution to the new one
----------------------------------------------------------

7. Other minor tasks
--------------------

* Change the ArcheOS version on the website (:ref:`archeos-website` package) to the new one
* Inform the ArcheOS community about the release (Mailing List, Social networks, Website)
* Change milestones into the `ArcheOS main repository on Github`_ to reflect the **hypatia**

.. _GitHub repository for archeos-meta: https://github.com/archeos/archeos-meta
.. _Vagrant: https://www.vagrantup.com/
.. _ArcheOS main repository on Github: https://github.com/archeos/ArcheOS
.. _ArcheOS repository: https://github.com/archeos/ArcheOS/
.. _live-build: http://live.debian.net/
.. _ArcheOS repository: https://github.com/archeos/ArcheOS
