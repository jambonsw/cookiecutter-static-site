.. _generation:

===================================
Generating a Static Website Project
===================================

With all of your :ref:`Prerequisites <prerequisites>` installed, and an
:ref:`AWS account with IAM user account <aws>`, we can actually generate
the project that will quickly deploy your website.

Section Goals
=============

In all cases, our goal is to use |cookiecutter|_ to download the
|cookiecutter-static-site|_ project (this project!) to jump start our
work by generating a static website project. The project will  make
deploying the static website to the cloud as easy as possible.

In the :ref:`first walkthrough <project-without-virtualenvwrapper>`
below, we will do this without any complications. In the :ref:`second
walkthrough <project-with-virtualenvwrapper>`, we will use |virtualenvwrapper|_ to separate our project
tools from other projects.

`virtualenvwrapper` : to use, or not to use?
============================================

If you're planning to learn Python, or use any other Python projects, I
strongly encourage you to use |virtualenvwrapper|_ (discussed and
installed in the :ref:`Prerequisites section <prerequisites>`).

If you have no intention of using multiple Python projects or
programming Python, you do not need to use |virtualenvwrapper|_. Even if
you plan to generate multiple static websites using this project
template, you will not need |virtualenvwrapper|_.

.. _project-without-virtualenvwrapper:

Generating the project without `virtualenvwrapper`
==================================================

Our first task is to install |cookiecutter|_. In your terminal, write
the following code, without the dollar sign (which is shown to designate
the fact that this is a terminal).

.. code:: console

    $ pip install cookiecutter

Now that you have |cookiecutter|_ installed, we can use |cookiecutter|_
to use the |cookiecutter-static-site|_ template to create our new
project.

.. code:: console

    $ cookiecutter gh:jambonsw/cookiecutter-static-site

|cookiecutter|_ will prompt you for information to customize your project.
Below is an example of the questions asked (but may not reflect the most
current questions!).

.. _project_prompt:

.. code:: console

    project_name [My Static Website]: JamBon Software
    project_slug [jambon-software]: jambonsw
    domain_name [example.com]: jambonsw.com
    aws_access_key_id [XXXXXXXXXXXXXXXXXXXX]:
    aws_secret_access_key [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]:

The project slug will be used to create a new directory (folder) with
the project code in it. You can use the code below to navigate into
directory using the terminal (you'll need to replace `jambonsw` with the
slug of your own project).

.. code:: console

    $ cd jambonsw  # replace with the value you specified when prompted by cookiecutter

.. note::
   Your new project will automatically initiate a `git`_ project. If you
   do not want to use version control, or wish to use another version
   control system, you can easily delete the `git`_ project with the
   code below.

   .. code:: console

      $ rm -rf .git  # Warning: deletes with impunity
      $ rm -f .gitignore  # Warning: deletes with impunity

We then install all of the smaller Python tools (not listed in the
:ref:`prerequisites section <prerequisites>`!) necessary for our project.

.. code:: console

    $ pip install -r requirements.txt

Please note that whenever you work on this project, the scripts provided
will need to have specific information available: specifically, the
scripts expect to have several environment variables available in the
environment. To make your life easier, all of these variables are
specified in ``env.sh``. You will need to enter the command below
whenever you start working on this project (one of the major advantages
of |virtualenvwrapper|_ is that we only need to specify the variables
once).

.. code:: console

    $ source env.sh

.. Warning::
   Note that ``env.sh`` contains information that would allow someone to
   hack your website. Keep it safe and secure!

The ``unenv.sh`` script removes these secret variables from your
environment. Us the command below when you stop working on your project
(or you can simply close your terminal window).

.. code:: console

    $ source unenv.sh

Your project is ready to go! You can either read below to see how to do
the same with |virtualenvwrapper|_, or jump directly to instructions
about :ref:`how to obtain a security certificate <certificates>`.

.. _project-with-virtualenvwrapper:

Generating the project with `virtualenvwrapper`
===============================================

Much like in the :ref:`first walkthrough above
<project-without-virtualenvwrapper>`, the goal is to use |cookiecutter|_
to generate a project from the |cookiecutter-static-site|_ project.
However, this time we will separate the project logically according to
terminal environment, making it easy to run other code projects.

Make sure that you have properly installed |virtualenvwrapper|_, and
that you've created the necessary environment variables, as specified in
the `installation guide
<http://virtualenvwrapper.readthedocs.org/en/latest/install.html#shell-startup-file>`_.

To start, we want to create a new virtual environment. In the code
below, I name the project ``jambonsw``, in anticipation of the fact that
I will name the poject slug the same. The project slug is primarily used
to specify the name of the directory that contains the project.  You may
follow this convention, or name the environment as you please.

.. warning::
   Do not copy the dollar signs or anything before the dollar signs in
   the code!

.. code:: console

    $ mkvirtualenv jambonsw

Your terminal will change to show you that you are now working in a
virtual environment by printing the name of the environment in
parentheses before the dollar sign.

Use the code below if you wish to leave the environment.

.. code:: console

    (jambonsw) $ deactivate

To enable an existing environment, use the ``workon`` command with the
name of the environment.

.. code:: console

    $ workon jambonsw

In this environment, we then install |cookiecutter|_. Note that
|cookiecutter|_ will only be available if we're in the environment!

.. code:: console

    (jambonsw) $ cookiecutter gh:jambonsw/cookiecutter-static-site

As show in the :ref:`example code in the first walkthrough above
<project_prompt>`, |cookiecutter|_ will prompt you with various
questions to get you started.

We use the project slug (specified by you when prompted) to enter the
project directory (folder). Replace the ``jambonsw`` directory name in
the code below with the slug of your own project.

.. code:: console

    (jambonsw) $ cd jambonsw

.. note::
   Your new project will automatically initiate a `git`_ project. If you
   do not want to use version control, or wish to use another version
   control system, you can easily delete the `git`_ project with the
   code below.

   .. code:: console

      $ rm -rf .git  # Warning: deletes with impunity
      $ rm -f .gitignore  # Warning: deletes with impunity

To make our life easier in the long run, we can now associate this
directory with the environment. We do so with the
``setvirtualenvproject`` command.

.. code:: console

    (jambonsw) $ setvirtualenvproject

If you use the ``workon`` command while in another directory, the
command will automatically bring you to this directory.

We then install all of the smaller Python tools (not listed in the
:ref:`prerequisites section <prerequisites>`!) necessary for our project.

.. code:: console

    (jambonsw) $ pip install -r requirements.txt

One of the key advantages of using |virtualenvwrapper|_ is that we don't
need to source ``env.sh`` whenever we choose to work on the project.
Instead, we can get |virtualenvwrapper|_ to add the needed environment
variables to the environment for us. We simply copy the file to a place
where

.. Warning::
   The command below will replace the existing ``postactivate`` and ``postdeactivate`` file. If
   you edited it (perhaps while reading documentation elsewhere), please
   back it up or combine the files yourself.

.. code:: console

    (jambonsw) $ mv env.sh $WORKON_HOME/$(basename $VIRTUAL_ENV)/bin/postactivate
    (jambonsw) $ mv unenv.sh $WORKON_HOME/$(basename $VIRTUAL_ENV)/bin/postdeactivate

Your project is ready to go! Before you can deploy the website, however,
you'll need to :ref:`obtain a security certificate <certificates>`.

.. |cookiecutter| replace:: ``cookiecutter``
.. _`cookiecutter`: https://github.com/audreyr/cookiecutter
.. |cookiecutter-static-site| replace:: ``cookiecutter-static-site``
.. _`cookiecutter-static-site`: https://github.com/jambonsw/cookiecutter-static-site
.. _`git`: http://www.git-scm.com/
.. |virtualenvwrapper| replace:: ``virtualenvwrapper``
.. _`virtualenvwrapper`: https://pypi.python.org/pypi/virtualenvwrapper
