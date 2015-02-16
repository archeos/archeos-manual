.. _menu:

archeos-menu package
====================

.. include:: ../global.rst

This page is intended to explain to other ArcheOS developers (or who's
interested in) the ArcheOS menu.

Overview
--------

The ArcheOS menu is designed as possible following the `freedesktop.org
guidelines`_. This means that it should work quite and appear quite the same way
on all desktop environments that supports the XDG standard.

The menu is basically copied from the `kali linux`_ one, with minor
modifications.

The package
-----------

The `archeos menu package`_ contains all menu modifications, required
application files and some icons.

desktop-directories
^^^^^^^^^^^^^^^^^^^

In the *desktop-directories/* folder a `.directory` file contains all
information about the each submenu (including the main, *ArcheOS Linux*
menu). These files are formatted using the same syntax as the `.desktop` files,
using the `Type=Directory` directive.
An example of a `.directory` file:

::
   [Desktop Entry]
   Name=GIS Applications
   Type=Directory
   Icon=archeos-menu-gis.png

Note that the `Name=` directive defines the name that will appear on the actual
menu, the `Icon=` must point to an existing icon into */usr/share/icons/* (see
the dedicated section about icons).
These files will be copied during package build and installation into
*/usr/share/desktop-directories*.

desktop-files
^^^^^^^^^^^^^

In the *desktop-files/* folder each `.desktop` file contains information about
the entry that will populate the menu.

   
.. _freedesktop.org guidelines: http://standards.freedesktop.org/menu-spec/menu-spec-1.0.html
.. _kali linux: http://git.kali.org/gitweb/?p=packages/kali-menu.git;a=summary
.. _archeos menu package: https://github.com/archeos/archeos-menu
