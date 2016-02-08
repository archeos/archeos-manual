.. _development-policy:

ArcheOS development policy
==========================

Introduction
------------

This document contains polcies and workflow for ArcheOS development. Is intended as a "bird view" of the daily and extra-ordinary work the ArcheOS developers follows.

ArcheOS releases
----------------

ArcheOS releases follows roughly the Debian cycle, with a new release of ArcheOS when a new Debian is released. Sometimes can happens that ArcheOS is released long after Debian, depending on the time the developers (after all is a non-profit work) have to spend on packaging and testing and building.

Regular work
------------

This section describes the regular, day-to-day work the developers do when a new version of ArcheOS is released and consolidated. This means working primary on existing, already packaged software, bug fixing, collecting requests for next version and so on.

.. _bug-tracking:

Bug tracking
^^^^^^^^^^^^

This list should be exhaustive about what to do when a users reports a bug to ArcheOS.

* **Bugs in ArcheOS specific applications (eg. ``ppt``).**

  Bugs for internally developed software must be submitted to the corresponding GitHub repository. When triaged and fixed a new package version is created for the affected software adding a patch revision number. It is then included into the current **stable** distribution on reprepro so ArcheOS user can upgrade in the correct way.

* **Bugs for third-part software packaged by ArcheOS developers.**

  These bugs must be reported to upstream developers. If a new version is available to fix this bug ArcheOS developers will fetch and package it. Will be then included in the **stable** distribution or reprepro so ArcheOS users can upgrade it.
  If the upstream maintainer cannot fix the bug ArcheOS developers can try to, being sure to send the patch to the upstream developers after the bug fix is confirmed.

* **Bugs for Debian software.**

  As stated in the `Debian Derivatives Guidelines`_ bugs must be submitted (after triaging) to the `Debian bug-tracking system`_. When a patch will be available Debian will create a new package and release it using the usual channels. No intervention from ArcheOS developers should be needed in this case.

* **Bugs related to the ArcheOS system.**

  This can include bugs affecting some way the behavior of the live system (eg. "Can't boot"). The bug should be reported to the `main ArcheOS repository bug tracking system`_.

* **Bugs related to the ArcheOS menu.**

  These bugs must be submitted to the `archeos-menu package bug tracking system`_. ArcheOS developers will then fix the issue and prepare a new ``archeos-menu`` version to be uploaded in the current **stable** repository for upgrading the usual way.

.. _feature-request:

Feature request
^^^^^^^^^^^^^^^

As a general rule, requests for features (new software packaging, software modifications, and so on) submitted to ArcheOS will go to the next release. Exceptionally some very important features can be integrated into the current release. In this case consider them as a "bug" rather than a "feature" (see section :ref:`bug-tracking`).

* **Request for new software packaging.**

  These requests must be submitted to the `archeos-meta bug tracking system`_. The milestone must be set to **archeos-next** and the appropriate label. ArcheOS developers should then check that:

  * The software license is compatible with ArcheOS (see the `Debian Free Software Guidelines`_ for more information about).
  * The software can be packaged for Debian.
  * The software is actually useful for archaeological purposes and cannot be easily obtained other ways.
  * The software does not fully overlaps other included software's features. In this case the new one can be choosen if considered better by the community and the old one discarded.

  The software will then be included in the next ArcheOS release.

* **Request for new software inclusion.**

  This is for software that is already present into the Debian repositories at the version needed and with all required features. Also in this case an issue must be opened to the `archeos-meta bug tracking system`_ with milestone **archeos-next** and appropriate labels.
  The software will then be included in the next ArcheOS release.
  
* **Request for new feature in existing software.**

  If this kind of feature can be enabled in an already included software (eg. using a compilation option), this should be reported in the ArcheOS software repository or in `archeos-meta bug tracking system`_, depending if the software is produced/packaged by ArcheOS developers or if just included as deendency in ``archeos-meta``. Same checks for new software packaging should be performed.
  The software will then be included in the next ArcheOS release.

.. _working-on-repositories:

Working on repositories
^^^^^^^^^^^^^^^^^^^^^^^

Some high-level guidelines and reminders about working on ArcheOS repositories:

* ArcheOS repositories are all hosted on Github, under the `ArcheOS organization`_. Access to these repositories in write mode is only granted to the ArcheOS developers.
* Preferred way to submit new changes to important branches of the repositories (eg. **master**) is throught `Github pull-requests`_. If you feel confident and your modifications does not need to be reviewed by someone else, you can directly push your commits to the repository.
* Usually the day-to-day job is done on the **master** branch (discouraged) or in a separate branch (eg. **devel**) that will be then merged to **master** when done.
* When working on a feature that will go into the next ArcheOS release use the **archeos-next** branch. This branch will be then merged into master when the work on the new release starts (see :ref:`new-release` section about).
* The preferred tool to build packages in archeos is `git-buildpackage`_. See the :ref:`developers-toolchain` page and single packages pages to get some examples on how to build a package.
* Each package must be correctly tagged with ``dch`` and ``git-buildpackage``. This is needed both for us to easily keep track of modifications and for reprepro inclusion.
* Some packages needs to be tagged accordingly to the ArcheOS release number. See the :ref:`package-versioning` section about. 

.. _new-release:

New release
-----------

This section contains all steps, although at high-level, needed when a new ArcheOS version has to be released.

Preliminary steps
^^^^^^^^^^^^^^^^^

#. **Codename**

   A codename must be choosen before the actual new release process starts. The codename will be infact used into **reprepro** to create the new distribution and into packages.

#. **Supported architectures**

   Usually amd64 and i686 architectures are supported

#. **Artwork**

   Artwork theme must be coherent in all distribution parts (GRUB, Isolinux, desktop manager, etc.) and it's subject should be about the codename.

Packages
^^^^^^^^

Some guidelines about packaging workflow for new ArcheOS release:

* 

Buildbot
^^^^^^^^

On a new ArcheOS release also the `buildbot`_ configuration should be updated to reflect the new Debian release.

The configuration is stored in the `buildbot-config repository on GitHub`_. Edit the `master.cfg`_ appropriately to reflect the new version (hint: search for the ``distribution`` var).

Then reload the buildbot server with the new configuration and make sure all build works.

.. _Debian Derivatives Guidelines: https://wiki.debian.org/Derivatives/Guidelines#Bug_reports
.. _Debian bug-tracking system: https://www.debian.org/Bugs/
.. _main ArcheOS repository bug tracking system: https://github.com/archeos/ArcheOS/issues/
.. _archeos-menu package bug tracking system: https://github.com/archeos/archeos-menu/issues
.. _archeos-meta bug tracking system: https://github.com/archeos/archeos-meta/issues
.. _Debian Free Software Guidelines: https://www.debian.org/social_contract#guidelines
.. _ArcheOS organization: https://github.com/archeos
.. _Github pull-requests: https://help.github.com/articles/using-pull-requests/
.. _git-buildpackage: https://wiki.debian.org/PackagingWithGit

.. _buildbot: http://build.archeos.eu/
.. _buildbot-config repository on GitHub: https://github.com/archeos/buildbot-config
.. _master.cfg: https://github.com/archeos/buildbot-config/blob/master/master.cfg
