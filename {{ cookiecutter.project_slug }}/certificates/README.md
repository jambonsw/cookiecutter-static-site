# TLS Certificates Directory

TLS Certificates are used to secure the connection between computers
when accessing websites.

Before actually creating the Cloud Formation stack with the templates
provided in this project, you will need to obtain a certificate and
upload the certificate to your Amazon Web Services account.

The goal is to have three files in this directory.

1. a private key
2. a security certificate
3. a certificate chain proving the validity of our certificate

The high-level overview for how to do this is:

```console
$ cd certificates
$ openssl genrsa 2048 > private-key.pem
$ openssl req -new -key private-key.pem -out csr.pem
$ # Buy Cert; upload CSR
$ # for any files received:
$ openssl x509 -in jambonsw_com.crt -outform pem -out jambonsw_com_cert.pem
$ # 3 files expected: certificate, certificate chain, private key
$ # for example, this might be: jambonsw_com_cert.pem jambonsw_com_ca_chain.pem private-key.pem
```

This will allow you to upload the three files using:

```console
$ # awscli must be available; using a virtual environment is recommended
$ make upload-cert
```
