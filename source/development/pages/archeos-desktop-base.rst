.. _archeos-desktop-base:

archeos-desktop-base package
============================

.. include:: /global.rst

Source
------

* `archeos-desktop-base on GitHub`_
* `git repository`_

Overview
--------

This package creates the `desktop-base`_ Debian packages. It brings artwork, wallpapers and such on the live/installed system.

.. include:: ../build-instructions.include

Note that the ArcheOS version must be higher than the available debian one in order to be preferred to the upstream package.

The package
-----------

The ``desktop-base`` package is a standard debian package used to bring arwtork customization across the various desktop managers. 
It contains (among the other things):

* Grub wallpaper
* KDM/GDM3/LightDM/.. wallpaper
* Gnome/KDE/other desktop background
* Splash and KDM themes for KDE

The customization of this package is suggested in the `Debian derivatives guidelines`_.

ArcheOS copied the customization comparing the `upstream package`_ with the `Kali Linux one`_.

List of modified files (artwork and settings)
---------------------------------------------

* archeos-desktop-base/backgrounds/archeos-wallpaper_1024x768.png
* archeos-desktop-base/backgrounds/archeos-wallpaper_1280x1024.png
* archeos-desktop-base/backgrounds/archeos-wallpaper_1280x800.png
* archeos-desktop-base/backgrounds/archeos-wallpaper_1600x1200.png
* archeos-desktop-base/backgrounds/archeos-wallpaper_1920x1080.png
* archeos-desktop-base/backgrounds/archeos-wallpaper_1920x1200.png
* archeos-desktop-base/backgrounds/archeos.xml
* archeos-desktop-base/debian/postinst
* archeos-desktop-base/emblems/emblem-debian.icon
* archeos-desktop-base/emblems/emblem-debian.png
* archeos-desktop-base/gdm3/10-desktop-base-settings
* archeos-desktop-base/gdm3/background.png
* archeos-desktop-base/gdm3/background.svg
* archeos-desktop-base/gdm3/login
* archeos-desktop-base/gdm3/login-background.svg
* archeos-desktop-base/gnome-backgrounds.xml
* archeos-desktop-base/grub/archeos-grub.png
* archeos-desktop-base/kdm-theme/archeos
* archeos-desktop-base/Makefile
* archeos-desktop-base/plymouth/archeos

Howto
-----

Update with Debian upstream version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: todo

.. _archeos-desktop-base on GitHub: https://github.com/archeos/archeos-desktop-base
.. _git repository: git@github.com:archeos/archeos-desktop-base.git
.. _desktop-base: https://packages.debian.org/search?keywords=desktop-base
.. _Debian derivatives guidelines: https://wiki.debian.org/Derivatives/Guidelines
.. _upstream package: http://svn.debian.org/wsvn/debian-desktop/packages/trunk/desktop-base
.. _Kali Linux one: http://git.kali.org/gitweb/?p=packages/desktop-base.git;a=summary
