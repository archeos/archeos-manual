.. _developers-toolchain:

ArcheOS developers toolchain
============================

This page list all tools needed by ArcheOS developers to build common packages and how to setup and configure them correctly.

Obviously most of them are common to all Debian packagers toolchain.

Tools list
----------

* GPG with a generated public/private keypair

Install **gnupg** if is not alreay installed on you computer and generate a keypair: ``gpg --gen-key``

Answer all the questions, specifically: 

#. Use **RSA and RSA** option to be able to both sign and ecrypt
#. The keysize should be no smaller than **2048** bits long
#. Set the exiry date (**not expire** is a good option in this case)
#. Set your **Real name**, your **Email address** and an optional **Comment** that will be displayed to distinguish the key
#. Enter a good **Passphrase** and generate the key


* git-buildpackage
* create the cowbuilder base
* build-essential
* rmadison to check version of package in all Debian repositories (useful)
