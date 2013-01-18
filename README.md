Archeos-manual - The Official ArcheOS Documentation
===================================================

This README file contains the some useful notice about the ArcheOS documentation package and source.
The documentation is build using [Sphinx] [1], so check how to use it and all the dependencies into the "Dependencies" section.

Overview
--------

The aim of this documentation is to provide a single entry-point where all resources about ArcheOS are stored and where all people working on the distribution can collaborate.
The documentation is written in the [Markdown] [2] markup language, then compiled in various formats (see Formats section).
HTML and MAN pages are used to build the debian package too, while other formats (HTML, ePub, PDF, etc.) are made available to the ArcheOS website (see Automation section).

Repository layout
-----------------

This repository contains the debian files used to build the package as well as the documentation itself.

├── build           _Where output files are produced and stored. Largely ingored by git_  
├── debian          _Debian packaging files_  
│   ├── ...  
|  
├── Makefile        _Makefile to build the various targets_  
├── README.md       _The file you are reading_  
└── source          _Source files that will be compiled_  
|   ├── conf.py     _Configuration for Sphinx_  
|   ├── index.rst   _Main source file_  
|   ├── _static     _Folder where CSS are placed_  
|   └── _templates  _Folder where HTML templates are placed_  

Formats
-------

Manual build the documentation
------------------------------
### Requirements to build the documentation
### Build commands

Debian package
--------------

Automation
----------

Collaborate
-----------
### GIT versioning
### Write the documentation for ArcheOS

Notes
-----
[1]: http://sphinx-doc.org/                "Sphinx"
[2]: http://en.wikipedia.org/wiki/Markdown "Markdown"
