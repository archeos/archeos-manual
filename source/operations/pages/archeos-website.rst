.. _archeos-website:

archeos-website package
======================

.. include:: /global.rst

This page describes the state of art and process related the ArcheOS website.

Source
------

* `archeos-website on GitHub`_
* `git repository`_

Overview
--------

The ArcheOS website is built with Sphinx from the `git repository`_. 

Build the website
-----------------

Prerequisites
=============

* `Sphinx`_ installed system-wide or inside virtualenv

Procedure
=========

Simply clone the `git repository`_ and run ``make clean && make html`` in the cloned folder. The output should be available to be opened in browser (try opening **_build/html/index.html**).

Upload to server
================

Use ftp to upload the content of the **_build/html/** folder on the documentroot of archeos.eu server (currently hosted at tophost).)

Other
-----

Test website
============

If you want to try changes to the website before pushing to prod a virtualhost for http://test.archeos.it (or http://test.archeos.eu ) is present on **farpoint**.

Simply:

* Go to **farpoint.archeos.eu**
* Pull latest changes on **/srv/website/archeos-website** on the desired branch (usually master)
* Run ``make clean && make html`` on the above folder
* Test pointing your browser to http://test.archeos.eu/

.. _archeos-website on GitHub: https://github.com/archeos/archeos-website
.. _git repository: git@github.com:archeos/archeos-website.git
