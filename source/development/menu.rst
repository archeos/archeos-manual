.. _menu:

archeos-menu package
====================

.. include:: ../global.rst

This page is intended to explain to other ArcheOS developers (or who's
interested in) the ArcheOS menu.

Overview
--------

The ArcheOS menu is a submenu with the **ArcheOS Linux** title into XFCE standard menu that provides access to
virtually every important application installed in ArcheOS (at least, the
graphical ones). Due to the nature of the XDG specifications, the ArcheOS menu
is merged with the default one. This means that applications could appear in
different menus (eg. the **Scribus** application can be under **ArcheOS Linux ->
Publishing applications** and also under **Office**).

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

In the **desktop-directories/** folder a ``.directory`` file contains all
information about the each submenu (including the main, **ArcheOS Linux**
menu). These files are formatted using the same syntax as the ``.desktop`` files,
using the ``Type=Directory`` directive.
An example of a ``.directory`` file:

::

   [Desktop Entry]
   Name=GIS Applications
   Type=Directory
   Icon=archeos-menu-gis.png

Note that the ``Name=`` directive defines the name that will appear on the actual
menu, the ``Icon=`` must point to an existing icon into **/usr/share/icons/** (see
the dedicated section about icons).
These files will be copied during package build and installation into
**/usr/share/desktop-directories**.

desktop-files
^^^^^^^^^^^^^

In the **desktop-files/** folder each ``.desktop`` file contains information about
the entry that will populate the menu.
Each application that should to go into the menu must have a ``.destkop`` file
similar to this:

::

   [Desktop Entry]
   Version=1.0
   Type=Application
   Name=LyX Document Processor
   GenericName=Document Processor
   Comment=High level LaTeX frontend
   Exec=lyx %F
   TryExec=lyx
   Icon=lyx
   StartupNotify=false
   StartupWMClass=Lyx
   Terminal=false
   Categories=Office;WordProcessor;Qt;11-publishing;
   X-ArcheOS-Package=lyx
   MimeType=text/x-lyx;application/x-lyx;

Most times this can be find into ``/usr/share/applications/`` for packages that
comes with Debian and external packages that provides such files.
In order to create the ArcheOS menu, these files has been copied into the
**desktop-files/** folder and modified to reflect the ArcheOS menu structure.

Obviously other ``.desktop`` entries can be very different from the example above,
with more or fewer lines, but some information are mandatory:

* ``Name=`` is the name displayed on the menu
* ``Exec=`` the command that is actually run to launch the program
* ``Categories=`` a list of categories separated by ``;``. This directive decides
  where to put the entry in the menu (in which submenu). To put the application
  under ArcheOS submenu, a valid category must be chosen,
  eg. ``11-publishing``. See the :ref:`xml-menu-file` section.
* ``Icon=`` as stated before the icon must exists under ``/usr/share/icons/``
* ``X-ArcheOS-Package=`` this is needed to associate the ``.desktop`` entry with the
  installed debian package. Periodically the ``update-archeos-menu`` scans the
  installed packages and the ``.desktop`` files present into the
  **desktop-files/** folder and copies them into ``/usr/share/applications/``.

.. _xml-menu-file:

XML menu file
^^^^^^^^^^^^^

In the **menus/** folder the XML layout of the menu is saved. This will be
installed by the package into ``/etc/xdg/menus/merged-applications/``. The XML
reflects first the general structure (``<Layout> .. </Layout>`` tags). Then
starts to list all directories with the relative name (overridden by the
corresponding ``.directory`` file) and the category that will be included. The
``<Category> .. </Category>`` must match the ``Categories=`` directive in the
``.desktop files`` (see above).
Multiple categories can be listed in one submenu and if needed the
``<Filename> .. </Filename>`` can be used instead of categories to point to
an absolute ``.desktop`` file path (not recommended).

See the `freedesktop.org guidelines`_ for more information.

.. _other-menu-files:

Other menu files
^^^^^^^^^^^^^^^^

Listed below other files and direcotries in the package

* **apt.conf.d/** contains an APT configuration to run the
  ``update-archeos-menu`` after package installation.
* **menu-icons/** contains the icons for menu entries and for applications that
  does not provide a default icon or applications package by the ArcheOS
  developers.
* **update-archeos-menu** is a script that parses the ``Categories=`` directive
  into ``/usr/share/archeos-menu/applications/*.desktop`` files and copies them
  into the standard ``/usr/share/applications/`` folder. Only entries with the
  corresponding deb package installed are copied. This in case ArcheOS
  developers wants to create menu entries for optional package that aren't
  installed by default.

HowTo
-----

Create menu entry
^^^^^^^^^^^^^^^^^

For each archeos application that need to go into the "ArcheOS" submenu, the
following items must be created:

* An icon (PNG, 64x64px) into **menu-icons/64x64/apps/**
* (Optional) a svg vector icon into **menu-icons/scalable/**
* A desktop entry into **deskop-files/**. Use any ``.desktop`` file as template.
* The ``Category=`` entry must correspond to a category used in the menu. See
  the **menus/archeos-applications.menu** for the complete list of categories
  (eg. ``Category=05-cad-applications;``)
* Multiple categories can be assigned using the ``;`` separator.
* The ``Icon=`` entry must exists somewhere into ``/usr/share/icons`` or must be
  inserted into the **menu-icons/64x64/apps/** folder.
* The ``X-Archeos-Package=`` entry must match the corrisponding ArcheOS debian
  package (installed). This information will be used by the
  **update-archeos-menu** script to build the actual list of applications into
  ``/usr/share/applications/``. This allows to create desktop files that will
  not be used until the actual deb package is installed.

Add a new submenu
^^^^^^^^^^^^^^^^^

To add a new submenu:

* Add a new ``<Menuname> .. </Menuname>`` like the others into the ``<Layout>``
  section into **menus/archeos-applications.menu** file (see others).
* Add a new ``<Menu> ... </Menu>`` stanza into **menus/archeos-applications.menu**
  similar to the other.
* The ``<Directory> ... </Directory>`` tag must contain the filename of the
  desktop entry (see below)
* The ``<Include> ... </Include>`` tag must contain a list of categories that
  applications files (see above) must contain. If no applications contains
  this category the menu **will not be displayed**.
* Add a new ``.directory`` file into **desktop-directories/** like the other ones
* The ``Type=`` entry must be ``Directory``
* The ``Icon=`` entry must exists somewhere into ``/usr/share/icons`` or must be
  inserted into the **menu-icons/64x64/apps/** folder (see above).

.. _freedesktop.org guidelines: http://standards.freedesktop.org/menu-spec/menu-spec-1.0.html
.. _kali linux: http://git.kali.org/gitweb/?p=packages/kali-menu.git;a=summary
.. _archeos menu package: https://github.com/archeos/archeos-menu
