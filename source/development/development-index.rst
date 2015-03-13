.. _development:

Guidelines for ArcheOS developers
=================================

.. include:: /global.rst

Here you will find some useful resources for ArcheOS developers

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
