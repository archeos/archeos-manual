.. new-archeos-release:

New ArcheOS Release
===================

This page describes all steps necessary to release a new ArcheOS version.

Create new reprepro distribution
--------------------------------

Update build toolchain
----------------------

Re-packaging tasks
------------------

Check packages dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To check all packages that needs to be upgraded before going on the next ArcheOS version, a method could be the following: assuming that all packages in ArcheOS are brought by the archeos-* metapackages, just setup a plain, vanilla Debian. The Debian version obviously should be the same of the proposed new ArcheOS (in this example, Debian Jessie).

After that the installation is done (you can use tools such as **Vagrant** to speed up this), add the ArcheOS stable repositories. We need to checkout the current available ArcheOS packages (and metapackages) against a new version so in our example we'll add the **theodoric** repositories:

* ``echo 'deb http://apt.archeos.eu/ theodoric main contrib non-free' > /etc/apt/sources.list.d/archeos.list``
* Update the repository cache: ``apt-get update``
* Install the ``archeos-keyring`` package to avoid the annoying warning about the repository key: ``apt-get install --yes archeos-keyring``
* Update the cache again: ``apt-get update``

Now we can try to install each metapackage: open the **archeos-meta/debian/control** file and scroll metapackage after metapackage and try to install each one, for example:

* ``apt-get install archeos-3d``

If it prompts for some errors it means that some of the packages contained into archeos-3d cannot be installed due to dependencies issue. Then try to install the single, incriminated package to find out which dependency is broken.

Annotate each broken dependency in a issue or in a wiki page on the `archeos-meta repository`_ so it will be easy to keep track later.

When you will have a list of all broken packages:

* Clone the **archeos-meta** repository
* Create a **archeos-next** branch (ora name it with your new codename if already available)
* Edit the **debian/control** file and delete each broken dependency. Add new packages (if any) and eventually remove also packages not needed anymore
* Commit the changes
* Edit the changelog the usual way (``git dch -R``) to reflect the new ArcheOS version number and codename
* Build the package the usual way (``git-buildpackage``) and be sure is named the new way
* Upload it to the apt repository on **farpoint.archeos.eu** (using ``dupload`` if you want) and load it into the **archeos-next** distribution of **reprepro**

This way you have a working version of all metapackages althought incomplete. When all missing software will be fixed and reintroduced you edit again the **archeos-meta** control file and build the package again.

Change package versions
^^^^^^^^^^^^^^^^^^^^^^^

Change metapackages version
---------------------------

.. _archeos-meta repository: https://github.com/archeos/archeos-meta
