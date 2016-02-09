.. _certificates:

===============================
Obtaining Security Certificates
===============================

Unsecured HTTP (the protocol that computers use to communicate over the web) is
being phased out. Securing your website is no longer a recommendation;
encrypting communication is becoming a modern requirement for websites.

Section Goals
=============

The goal of this section is to upload a security certificate for AWS to
use to encrypt communication to and from your website.

To obtain a certificate,  we must first buy the right to a certificate
from a Certificate Authority (|CA|).  We then use OpenSSL to generate
cryptographic keys, which in turn allows us to generate a Certificate
Signing Request (|CSR|). We return to the |CA| with our |CSR| to obtain
(generate and activate) our certificate.

We will then upload three things to AWS:

1. a private key
2. a security certificate
3. a certificate chain proving the validity of our certificate

Using a classical |CA| will cost you $10-20/year. If you're feeling daring
(and comfortable with the command line) you may be interested in `Let's
Encrypt`_ (|LE|). |LE| is a free, open-source |CA|. However, |LE| is currently
in beta, and can be a bit finicky. Once I think |LE| is ready for you, I
will update this section with instructions on how to use it. In the
meantime, you're on your own!


Obtaining a Security Certificate from a Certificate Authority
=============================================================

.. Warning::
   At the end of the section, you will need to be able to access the
   email associated with your domain on whois. Please take a moment to
   ensure that you are able to do so. If you don't know what this means,
   please reach out to your domain registrar's support team.

Security certificates rely on `Public-Key Cryptography
<https://en.wikipedia.org/wiki/Public-key_cryptography>`_. To obtain a
security certificate, we first need to generate a set of keys. We will
then create a Certificate Signing Request (|CSR|) for the keys, which will be
the information a Certifcate Authority needs to generate a certificate
for us.

Before any of that, however, we need to buy the ability to request a
certificate from a Certificate Authority (|CA|).

Buying a Certificate
--------------------

When you buy a certificate from a |CA|, you're not actually buying the
certificate; you're buying the right to generate and activate a
certificate using a |CSR| in the future.

There are many places to buy a certificate. Among them are
(alphabetically):

- `Comodo <https://ssl.comodo.com/comodo-ssl-certificate.php>`_
- `DigiCert <https://www.digicert.com/welcome/ssl-plus.htm>`_
- `GeoTrust <https://www.geotrust.com/ssl/ssl-certificates-premium/>`_
- `RapidSSL <https://www.rapidssl.com/buy-ssl/ssl-certificate/>`_
- `Thawte <https://www.thawte.com/ssl/ssl123-ssl-certificates/>`_

Generally, you can find better deals (price-wise) when buying through a
domain registrar. I currently use `NameCheap's Certificate options
<https://www.namecheap.com/security/ssl-certificates/domain-validation.aspx?aff=96071>`_,
and would recommend either `Comodo PositiveSSL for $9/yr
<https://www.namecheap.com/cart/addtocart.aspx?producttype=ssl&product=positivessl&action=purchase&period=1-YEAR-NOTTRIAL&aff=96071>`_
or `RapidSSL for $10.95/yr
<https://www.namecheap.com/cart/addtocart.aspx?producttype=ssl&product=rapidssl&action=purchase&period=1-YEAR-NOTTRIAL&aff=96071>`_.
If you're looking to secure multiple domains, you'll want to evaluate
`other options
<https://www.namecheap.com/security/ssl-certificates/domain-validation.aspx?aff=96071>`_,
as AWS only allows a single certificate per website. Of course, if you
already have a domain registrar (other than NameCheap), it's worth
seeing what they have to offer. I furthermore recommend reaching out to
your registrar's support to discuss your options.

Once you've bought the ability to activate a certificate, you are ready
to proceed.

Generating a Certificate Signing Request
----------------------------------------

This section requires the use of OpenSSL, discussed in the
:ref:`Prerequisites section <prerequisites>`.

All of this work will occur in the certifcates directory of the :ref:`project
you generated last section <generation>`. You may optionally be in the
virtual environment you created.

.. code:: console

    $ cd certificates

To start, we generate a private key of length 2048 bits using the RSA
algorithm. We store it in a file called ``private-key.pem``.

.. code:: console

    $ openssl genrsa 2048 > private-key.pem

Now that we have a private key, we can generate a |CSR|, creatively named
``csr.pem``.

.. code:: console

    $ openssl req -new -key private-key.pem -out csr.pem

You will be prompted for the values of your certificate. The ``Common
Name`` field must be the main domain name for the website. Not all of
the fields need be specified. In many cases, the |CA| will ask that the
challenge password be left blank. When answering the questions for
JamBon Sofware, I entered the following values:

.. code:: console

    Country Name (2 letter code) [AU]:US
    State or Province Name (full name) [Some-State]:MA
    Locality Name (eg, city) []:Boston
    Organization Name (eg, company) [Internet Widgits Pty Ltd]:JamBon Software
    Organizational Unit Name (eg, section) []:
    Common Name (e.g. server FQDN or YOUR name) []:jambonsw.com
    Email Address []:

    Please enter the following 'extra' attributes
    to be sent with your certificate request
    A challenge password []:
    An optional company name []:

Now that you have a |CSR|, you will have to go to the website where you
bought your certificate, and activate the certificate. At some point in
the process, they will ask you for the certificate request: you will
either upload the ``csr.pem`` file, or else copy the contents of the
file into a textfield.

At the end of the activation process, you'll have the option of picking
how the |CA| will verify your ownership of the domain end how to send you
your certificate. The simplest of these options will be to

Once you have given the |CSR| to a |CA|, the |CA| will begin the process of
generating your certificate.

Preparing the Certificate for AWS
---------------------------------

It would be too simple if your |CA| simply sent you what you needed. In
this section we'll take a look at what your |CA| might send you, and what
to do with it in that case.

In all cases, the goal will be to have three files:

1. a private key
2. a security certificate
3. a certificate chain proving the validity of our certificate

AWS specifies that all of these files must be in the PEM format.

.. note::
   The text in the sections below will refer to certificates with the
   prefix ``jambonsw_com``, as this walkthrough is based on JamBon
   Software's own website. You will wish to name your certificates
   according to your domain. If your domain is ``andrew.pinkham.com``,
   you'd want to name the certificates with the prefix
   ``andrew_pinkham_com``.

You likely only need to read one of the sections below, depending on
what your |CA| sends you.

Receiving a Certificate and Bundle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you receive two files, one will be the certificate and the
other will be the chain bundle. When I ordered the `Comodo PostitiveSSL
<https://www.namecheap.com/cart/addtocart.aspx?producttype=ssl&product=positivessl&action=purchase&period=1-YEAR-NOTTRIAL&aff=96071>`_,
the two files I received were:

 - ``jambonsw_com.crt``
 - ``jambonsw_com.ca-bundle``

Save both files to the ``certificates`` directory of your generated
project. In my case, both of the files I received were already in PEM
format. However, just to make sure, we can use OpenSSL to convert them.

.. code:: console

    $ openssl x509 -in jambonsw_com.crt -outform pem -out jambonsw_com_cert.pem
    $ openssl x509 -in jambonsw_com.ca-bundle -outform pem -out jambonsw_com_ca_chain.pem

You could then delete the originals.

.. code:: console

    $ rm jambonsw_com.crt
    $ rm jambonsw_com.ca-bundle

In the ``certificates`` directory, you should now have:

- ``csr.pem``
- ``jambonsw_com_ca_chain.pem``
- ``jambonsw_com_cert.pem``
- ``private-key.pem``

You are now ready to :ref:`upload your certificate to AWS <uploadcert>`.

Receiving a Certificate, Multiple Chain Certs, and a Root
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:abbr:`CAs (Certificate Authorities)` will frequently send the |CA| chain as seperate files. Your goal is to
concatenate them into a single file, from least to most important. If
the email you receive does not tell you what the order is, you will have
to read the documentation on your |CA|'s site, or contact their support,
to determine what that order is.

One of the bundles I received from Comodo was:

 - ``AddTrustExternalCARoot.crt`` (Root CA Certificate)
 - ``COMODORSAAddTrustCA.crt`` (Intermediate CA Certificate)
 - ``COMODORSADomainValidationSecureServerCA.crt`` (Intermediate CA Certificate)
 - ``jambonsw_com.crt``

We start by ensuring that all of the files are in PEM format.

.. code:: console

    $ openssl x509 -in COMODORSADomainValidationSecureServerCA.crt -outform pem -out COMODORSADomainValidationSecureServerCA.pem
    $ openssl x509 -in COMODORSAAddTrustCA.crt -outform pem -out COMODORSAAddTrustCA.pem
    $ openssl x509 -in AddTrustExternalCARoot.crt -outform pem -out AddTrustExternalCARoot.pem
    $ openssl x509 -in jambonsw_com.crt -outform pem -out jambonsw_com_cert.pem

Now that all our files are in the right format, we can simply
concatenate the files into a single |CA| chain.

.. code:: console

    $ cat COMODORSADomainValidationSecureServerCA.pem > jambonsw_com_ca_chain.pem
    $ cat COMODORSAAddTrustCA.pem >> jambonsw_com_ca_chain.pem
    $ cat AddTrustExternalCARoot.pem >> jambonsw_com_ca_chain.pem

Finally, I opt to delete all of the unnecessary files (having backed up
the email from Comodo).

.. code:: console

    $ rm AddTrustExternalCARoot.crt
    $ rm AddTrustExternalCARoot.pem
    $ rm COMODORSAAddTrustCA.crt
    $ rm COMODORSAAddTrustCA.pem
    $ rm COMODORSADomainValidationSecureServerCA.crt
    $ rm COMODORSADomainValidationSecureServerCA.pem
    $ rm jambonsw_com.crt

In the ``certificates`` directory, you should now have:

- ``csr.pem``
- ``jambonsw_com_ca_chain.pem``
- ``jambonsw_com_cert.pem``
- ``private-key.pem``

You are now ready to :ref:`upload your certificate to AWS <uploadcert>`.

.. _uploadcert:

Uploading your Certificate
--------------------------

Now that you have a private key, a certificate, and a certificate chain, you
can upload the certificate to AWS to secure your website.

To do so, simply move to the root directory of your project (where the
``Makefile`` is), and enter the command below.

.. code:: console

    $ make upload-cert

Ta-da! Your certificate has been uploaded to AWS.  You are now ready to
:ref:`deploy your website <deploy>`.

.. |AWS| replace:: :abbr:`AWS (Amazon Web Services)`
.. |CA| replace:: :abbr:`CA (Certificate Authority)`
.. |CSR| replace:: :abbr:`CSR (Certificate Signing Request)`
.. |LE| replace:: :abbr:`LE (Let's Encrypt)`
.. _`Let's Encrypt`: https://letsencrypt.org/
