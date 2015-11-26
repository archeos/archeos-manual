.. _development:

Guidelines for ArcheOS developers
=================================

.. include:: /global.rst

Here you will find some useful resources for ArcheOS developers

Important
---------

Read the :ref:`development-policy` before!

List of documentation pages
---------------------------

.. toctree::
    :maxdepth: 1
    :glob:

    pages/*

.. _howto-list:

List of HowTo for developers
----------------------------

.. toctree::
    :maxdepth: 2
    
    pages/developers-howto.rst

.. _archeos-dev-tools:

ArcheOS developers tools
------------------------

A small list of useful tools and resources for ArcheOS developers:

* `ArcheOS GitHub organization`_
* `ArcheOS Continuous Integration`_ (BuildBot)
* :ref:`developers-toolchain`

.. _package-versioning:

Special ArcheOS packages versioning
-----------------------------------

The following packages major version MUST match the current ArcheOS version:

* ``archeos-meta``
* ``archeos-keyring``
* ``archeos-manual``
* ``archeos-menu``

For example: if ArcheOS is currently on version 5 (Theodoric), the
``archeos-meta`` major version must be like **5.x**.

When ArcheOS will reach the next version obviously all the above packages must
be modified to match the new version. This can be also done previously in a
separate branch.

.. _contact-developers:

Contact ArcheOS developers
--------------------------

Official development mailing list: archeos-dev@lists.linux.it
IRC: channel **#archeos** on _`freenode` (chat.freenode.net)

.. _freenode: https://freenode.net/
.. _ArcheOS GitHub organization: https://github.com/archeos/
.. _ArcheOS Continuous Integration: http://build.archeos.eu
