.. _archeos-manual:

archeos-manual package
======================

.. include:: /global.rst

This page describes the state of art and process related the ArcheOS documentation project

Source
------

* `archeos-manual on GitHub`_
* `git repository`_


Overview
--------

Documentation for ArcheOS is built from a `single git repository`_. This means
that both the **archeos-manual** package and the documentation `browsable
online`_ are built using `Sphinx`_ using quite the same steps.

.. include:: ../build-instructions.include

Package
-------

The package is fairly simple, due to the use of custom debian helper sphinxdoc
option (see ``debian/rules``).

All information on how to build html pages, man pages, and so on are contained
into the ``Makefile``. The current targets are **html** and **man**.

The documentation is written in `reStructuredText`_ (rst) format, a quick primer
on the syntax for Sphinx can be found `here`_. All files can be found into the
**source/** folder within the package.

The documents in the **source/** are organized in a clear way:

* The **applications/** folder is the documentation relative to all applications
  installed into ArcheOS, specifying eventual changes made by ArcheOS developers
  and other significant information. One rst file per application should be
  created into the **applications/pages/** folder.
  As stated into the index, use the :ref:`apptemplate` to create new application
  page.

* The **tutorials/** folder is used for guides and tutorials. Like applications,
  is suggested to create one page per tutorial into the **tutorals/pages/**
  folder following the :ref:`tuttemplate` guidelines.

* The **development/** folder contains information for ArcheOS developers, how
  to build packages, caveats, instructions on how to customize the distribution
  and so on. Is intended mainly to remember us the usual procedures and track
  changes in ArcheOS. Also there the usual **page/** structure is used, with one
  page per package/guide/other.

Other files/folders

* **_static/** contains static files (js/images)
* **_templates/** contains the Sphinx template (defined into **conf.py**)
* **conf.py** contains the general directives for Sphinx (see `the documentation
  about`_)
* **global.rst** in sincluded in most pages and contains the image
  (logo). Contains also some cross-pages features.

Online documentation
--------------------

Contribute to the documentation
-------------------------------

.. _archeos-manual on GitHub: https://github.com/archeos/archeos-manual
.. _git repository: git@github.com:archeos/archeos-manual.git
.. _single git repository: https://github.com/archeos/archeos-manual
.. _browsable online: http://doc.archeos.it
.. _Sphinx: http://sphinx-doc.org/index.html
.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _here: http://sphinx-doc.org/tutorial.html
.. _the documentation about: http://sphinx-doc.org/config.html
