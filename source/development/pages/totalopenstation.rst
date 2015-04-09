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

Packages:

* ``python-stdeb``
* ``git-buildpackage``
* ``cowbuilder`` (or ``pbuilder``)

Procedure
---------

The **master** branch will be used to build the package, while the **upstream** branch will contain the original code

Repository fork
^^^^^^^^^^^^^^^

The upstream repository for this package is https://github.com/steko/totalopenstation
We need to fork it into archeos/totalopenstation (https://github.com/archeos/totalopenstation) using the GitHub web interface so we can push our modifications.

After forking we will clone it and add the ``steko`` remote so we can merge future development into our repos.

* ``git clone git@github.com:archeos/totalopenstation.git``
* ``git remote add steko https://github.com/steko/totalopenstation.git``
* ``git fetch steko``

Check with ``git remote -v``

Creation and first import
^^^^^^^^^^^^^^^^^^^^^^^^^

1. First clone the upstream repository: ``git@github.com:archeos/totalopenstation.git``
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

We can now commit the changes with ``git commit -a -m 'Debianization'`` and check the tags: ``git tag --list``.
As we can see the tag **upstream/0.3.1pre** has been created and we'll use to notify git-buildpackage which tree use for upstream.

If all went fine a new entry inside **changelog** can be created with: ``git dch -R``
The entry must be placed above the existing one with a new version number like `0.3.1-archeos1`

The package can be now build with:

* ``mkdir ../build-area/``
* ``git-buildpackage --git-export-dir=../build-area/ --git-upstream-tree=upstream/0.3.1pre --git-tag``
* ``git push -u origin master``
* ``git push -u origin upstream``
* ``git push --tags``

.. note:: The **build-area** folder can be also specified as default into the **~/.gbp.conf** file so we don't need to pass ``--git-export-dir=`` option every time.

After the compilation we will find all files we need into the **../build-area/** folder, including debs and archives. We will upload to the ``reprepro`` repository later.

Daily packaging
^^^^^^^^^^^^^^^

Once the package has been built the first time we only need to follow the usual ArcheOS/git-buildpackage workflow to build it: if we check tags (``git tag --list``) we will see that a new tag called **debian/0.3.1-archeos1** has been automatically created for us.

So, assuming that we set the ``export-dir = ../build-area/`` and ``tarball-dir = ../tarballs/`` options inside our **~/.gbp.conf**, we only need to run:

* ``git-buildpackage``

To rebuild the totalopenstation package.

New upstream changes
^^^^^^^^^^^^^^^^^^^^

The workflow in this case can be a little bit tricky: we need to first to merge the original tops repository into our ``upstream`` branch and then merge our ``upstream`` branch into our ``master`` branch.

* ``git fetch steko``

Assuming you followed the above tutorial naming convention you will have these branches:

::

      master
      pristine-tar
    * upstream
      remotes/origin/master
      remotes/origin/upstream
      remotes/steko/gh-pages
      remotes/steko/master

Follow these steps:

* ``git fetch steko``
* Switch to our ``upstream`` branch: ``git checkout upstream``
* Merge the ``steko/master`` branch into our ``upstream`` branch: ``git merge origin/steko``
* Switch to ``master`` branch and merge the ``upstream`` branch into it: ``git checkout master; git merge upstream``

.. _totalopenstation on GitHub: https://github.com/steko/totalopenstation
.. _totalopenstation ArcheOS repository: https://github.com:archeos/totalopenstation.git

