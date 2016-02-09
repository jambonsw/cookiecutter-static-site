.. _deploy:

=======================================
Deploying your Static Site to the Cloud
=======================================

You have the tools. You have the accounts. You have security. Let's put
some content in the cloud.

Section Goals
=============

We will first use the scripts to create a Cloud Formation stack. This
will create all of the cloud resources we need to store our website.

We will then upload the website to the cloud.

Preparing for Work
==================

If you're using |virtualenvwrapper|_, simply activate the environment.

.. code:: console

    $ workon jambonsw  # Replace jambonsw with the name of your own env
    $ # if you don't remember the name of your env
    $ # type workon, and then tap the tab button on your keyboard twice

If you're not using |virtualenvwrapper|_, you need to load the
appropriate environment variables.

.. code:: console

    $ cd Path/To/Your/Project
    $ source env.sh

Creating a CloudFormation Stack
===============================

To create a CloudFormation stack, we need a script (currently in
:file:`{your_project_dir}/certificates/cloudformation_build.json`) and
parameters for that script (will be created at
:file:`{your_project_dir}/certificates/cloudformation_parameters.json`).

To make your life as simple as possible, a script has been supplied to
generate the parameters for you (this works as long as you've already
uploaded a security certificate).

.. code:: console

    $ ./generate-params.sh

If the script succeeds, it will delete itself after creating
:file:`{your_project_dir}/certificates/cloudformation_parameters.json`.

.. Note::
   If you're using |git|_, I recommend adding the new file to your
   repository.

   .. code:: console

      $ git add certificates/cloudformation_parameters.json
      $ git commit -m "Generated CloudFormation parameters."

With all the right files in place, we can now create the CloudFormation
stack with the simple command listed below.

.. code:: console

    $ make create-stack

This can take up to 20 minutes to complete.

Pointing your Domain to Amazon's Nameservers
============================================

Now that you have a set of resources in the cloud, you need to point
your domain name at the cloud. You are setting the nameservers of your
domain.

To get the Amazon Nameservers for your website, simply use the command
below.

.. code:: console

    $ make dns

You will need to go to you domain's registrar and specify these
nameservers. If you don't know how to do this, look through the FAQ
section of your registrar's website, or contact support.

Uploading Content to the Cloud
==============================

We now have the infrastructure for a website, but we've not actually put
any content in the cloud yet. The command below changes that, by
uploading all of the content in the :file:`{your_project_dir}/content/`
directory. By default, the template includes and extremely basic
webpage.

.. code:: console

    $ make

And with that last command issued, you have successfully deployed your
website to the cloud.

Congratulations!

.. |git| replace:: ``git``
.. _`git`: http://www.git-scm.com/
.. |virtualenvwrapper| replace:: ``virtualenvwrapper``
.. _`virtualenvwrapper`: https://pypi.python.org/pypi/virtualenvwrapper
