.. _archeos-manual-operations:

ArcheOS manual
==============

.. include:: /global.rst

This page describes the procedure to update the manual pages for http://doc.archeos.eu

Overview
--------

The html pages for http://doc.archeos.eu are build from the :ref:`archeos-manual` package, see that page for info about building the documentation for archeos.

The same documentation is used to run the http://doc.archeos.eu website. On **farpoint.archeos.eu** there is a virtualhost for this.

To update the documentation on doc.archeos.eu:

* Login to **farpoint.archeos.eu**
* Pull the latest changes in **/srv/doc/archeos-manual** folder (using Git)
* Build the documentation with ``make clean && make html``
* Navigate to http://doc.archeos.eu to see the changes
