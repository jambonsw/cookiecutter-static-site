.. _intro:

============
Introduction
============

This project may seem silly. After all, `Amazon provides a full tutorial
on how to set up a static website in the cloud using S3 buckets and a
CloudFront distribution.
<https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html>`_
(You can also watch a `YouTube video with similar content
<https://www.youtube.com/watch?v=qiPt1NoyZm0>`_.)

So why use this template to generate a template? Well, the difficulty
with the tutorial is that it focuses entirely on the visual web console.
The net effect is that it takes time, is easily forgotten, and is not
reporoducible with code.

Far worse, however, is that the official Amazon tutorial does not follow best
practices:

- user setup is not covered
- the website is unsecured (no TLS certificate)
- DNS speed is ignored in favor of a bucket redirection trick

The |cookiecutter-static-site|_ template project aims to:

- be fast
- be easily reproducible
- generate the cloud infrastructure (with two commands)
- use a TLS security certificate to secure the website
- optimize DNS lookups for the website domain
- be forgettable (the template provides a :file:`Makefile` with all of
  the commands you'll need)

If the template were to recreate the entire Amazon tutorial, only two commands
would be necessary.

- ``aws cloudformation create-stack``
- ``aws s3 sync``

This walkthrough is about *mise-en-scène*. Getting setup is a little involved.
You'll have to get setup once, but you'll be off to the races for repeat
performances.

This walkthrough is aimed at people who have dabbled with the
commandline, but who may not be comfortable with it yet. We'll walk
through each and every step needed to get your site up in the cloud.
Your next step will be to :ref:`install the necessary prerequisites
<prerequisites>`.

If you are a developer, the `Read Me document
<https://github.com/jambonsw/cookiecutter-static-site/blob/master/README.md>`_
in the `GitHub project`_ is likely enough for you.

.. |cookiecutter-static-site| replace:: ``cookiecutter-static-site``
.. _`cookiecutter-static-site`: https://github.com/jambonsw/cookiecutter-static-site
.. _`GitHub project`: https://github.com/jambonsw/cookiecutter-static-site
