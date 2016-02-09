.PHONY: all create-stack delete-stack dns hosted-zone list-cert stack sync upload-cert

all: sync

upload-cert:
	aws iam upload-server-certificate \
		--server-certificate-name {{ domain_name|lower }} \
		--certificate-body file://{{ domain_name|lower|replace('.', '_') }}_cert.pem \
		--private-key file://private-key.pem \
		--certificate-chain file://{{ domain_name|lower|replace('.', '_') }}_ca_chain.pem \
		--path /cloudfront/

list-cert:
	aws iam list-server-certificates

create-stack:
	aws cloudformation create-stack \
		--stack-name {{ domain_name|lower|replace('.', '-') }} \
		--template-body file://aws_scripts/cloudformation_build.json \
		--parameters file://aws_scripts/cloudformation_parameters.json

stack:
	aws cloudformation update-stack \
		--stack-name {{ domain_name|lower|replace('.', '-') }} \
		--template-body file://aws_scripts/cloudformation_build.json \
		--parameters file://aws_scripts/cloudformation_parameters.json

hosted-zone:
	aws route53 list-hosted-zones \
		| jq ".HostedZones[] \
		| select(.Name == \"{{ domain_name|lower }}.\") \
		| .Id" \
		| tr -d \" \
		| cut -d"/" -f 3

dns:
	@aws route53 list-resource-record-sets \
		--hosted-zone-id `aws route53 list-hosted-zones \
			| jq ".HostedZones[] \
			| select(.Name == \"{{ domain_name|lower }}.\") \
			| .Id" \
			| tr -d \" \
			| cut -d"/" -f 3` \
		| jq ".[][] | select(.Type == \"NS\") \
		| .ResourceRecords[][]" \
		| tr -d \" \
		| sed 's/.$$//'

sync:
	aws s3 sync content s3://{{ domain_name|lower }} \
		--delete \
		--exclude "*.DS_Store" \
		--exclude "*.git/*" \
		--cache-control max-age=604800

delete-stack:
	aws cloudformation delete-stack \
		--stack-name {{ domain_name|lower|replace('.', '-') }}
