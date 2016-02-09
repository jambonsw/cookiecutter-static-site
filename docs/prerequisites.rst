.. _prerequisites:

================================
Installing Project Prerequisites
================================

This project relies on several programming tools, but can be used
without knowledge of programming languages.

.. note::
   Manually downloading and installing software---as indicated by the
   instructions in this walkthrough---is fine if you are not doing this
   very often. If you are learning to develop or code, I urge you to
   look into package management software, as it will save you time in
   the long run. If you are on BSD or Linux, your system comes with a
   package manager. If you are on a Mac, I recommend `MacPorts
   <http://macports.org/>`_ or `Homebrew <http://brew.sh/>`_. If you're
   on Windows, I hear good things about `Chocolatey
   <https://chocolatey.org/>`_.

Section Goals
=============

This section prepares you for:

1. Using the |cookiecutter-static-site|_ template to generate a project

2. Generating security certificates to secure your website

3. Using the provided scripts in your new project to upload (deploy)
   your static website to the cloud

This section lists all of the tools required to perform the three steps
above.  Rather than provide detailed instructions for each installation,
this section refers you instead to installation instructions of each
utility.

The tools below are listed in the order they will be used.

Python and `pip`
================

Python version 2.7, 3.3, 3.4, or 3.5 must be installed for both project
generation and site deployment.  If you're on a modern Mac, Python 2.7
is already installed for you (but you are encouraged to `upgrade Python
<https://www.python.org/downloads/>`_).  If you're on Windows, you will
need to `install Python <https://www.python.org/downloads/>`_. If you're
on BSD or Linux, you don't need my help.

Python is installed with |pip|_, a package manager for Python
packages/applications.

`virtualenvwrapper`
===================

|virtualenvwrapper|_ is an optional tool that allows for the logical
separation of installed packages. I highly recommend using it.

If you are on Windows, you may wish to use either
|virtualenvwrapper-win|_ or |virtualenvwrapper-powershell|_. The
|virtualenv-installation|_ has more information.

.. |virtualenv-installation| replace:: installation guide for ``virtualenvwrapper``
.. _virtualenv-installation: http://virtualenvwrapper.readthedocs.org/en/latest/install.html

OpenSSL
=======

Named after the now-deprecated Secure Sockets Layer security protocol,
OpenSSL is an open-source utility that allows for many cryptographic and
security applications. In this walkthrough, you will use it to obtain a
TLS security certificate for your website.

If you're on Windows, you will need to google installations instructions
(Sorry, I cannot help you here.) If you're on a Mac, then OpenSSL is
already installed. On Linux and BSD, if OpenSSL is not on your system,
then your package manager should quickly fix that problem for you.

`jq`
====

Whereas Python, `pip`, and `virtualenvwrapper`_ are tools for generating
the static site deployment project, |jq|_ is a tool necessary for the
deployment of the site to the cloud. You will not need to use the tool
yourself, but the deployment scripts we will use do rely on the tool.

Downloads and installation instructions may be found `here
<https://stedolan.github.io/jq/download/>`_.

.. |cookiecutter-static-site| replace:: ``cookiecutter-static-site``
.. _`cookiecutter-static-site`: https://github.com/jambonsw/cookiecutter-static-site
.. |jq| replace:: ``jq``
.. _`jq`: https://stedolan.github.io/jq/
.. |pip| replace:: ``pip``
.. _`pip`: https://pypi.python.org/pypi/pip
.. |virtualenvwrapper| replace:: ``virtualenvwrapper``
.. _`virtualenvwrapper`: https://pypi.python.org/pypi/virtualenvwrapper
.. |virtualenvwrapper-powershell| replace:: ``virtualenvwrapper-powershell``
.. _`virtualenvwrapper-powershell`: https://pypi.python.org/pypi/virtualenvwrapper-powershell
.. |virtualenvwrapper-win| replace:: ``virtualenvwrapper-win``
.. _`virtualenvwrapper-win`: https://pypi.python.org/pypi/virtualenvwrapper-win
