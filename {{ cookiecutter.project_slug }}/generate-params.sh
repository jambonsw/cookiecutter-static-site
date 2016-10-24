#!/usr/bin/env bash

PARAM_FILE="aws_scripts/cloudformation_parameters.json"

if aws_cli_loc="$(type -p "aws")" && [ -n "$aws_cli_loc" ]; then
    cert_id=$(aws iam list-server-certificates \
		| jq ".ServerCertificateMetadataList[] \
		| select(.ServerCertificateName == \"{{ cookiecutter.domain_name|lower }}\") \
		| .ServerCertificateId" \
		| tr -d \")
	if [ -z "$cert_id" ]; then
	    echo -e "\n\t!!! No certificate for that domain. Please upload a certificate first."
	else
        cat > $PARAM_FILE << EOF
[
    {
        "ParameterKey": "RootDomainName",
        "ParameterValue": "{{ cookiecutter.domain_name|lower }}"
    },
    {
        "ParameterKey": "ServerCertificateId",
EOF
        printf '        "ParameterValue": "%s"' $cert_id >> $PARAM_FILE
        cat >> $PARAM_FILE << EOF

    }
]
EOF
        rm generate-params.sh
    fi;
fi;
