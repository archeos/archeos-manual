-*- mode: markdown -*-
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

The ArcheOS documentation has been built successfully with these packages:
* Python 2.7.3 or higher
* Sphinx 1.1.3 or higher (better installed with easy_install into virtualenv)
* Markdown 2.2.1 or higher
* git-buildpackage (to build the debian package)

### Build commands

Debian package
--------------

Use `git-buildpackage` to build from source and follow the usual workflow while developing:

1. Edit files
2. Commit them with git
3. When a new release of the package is ready use `git-dch -R` to update changelog file
4. Add and commit the _debian/changelog_ file too.
5. Use `git-buildpackage --git-sign` to build the package at specified release and create tag
6. Push to the remote repository with `git push && git push --tags`

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
