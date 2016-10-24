#!/usr/bin/env bash

export DOMAIN='{{ cookiecutter.domain_name|lower }}'
export AWS_ACCESS_KEY_ID='{{ cookiecutter.aws_access_key_id }}'
export AWS_SECRET_ACCESS_KEY='{{ cookiecutter.aws_secret_access_key }}'
