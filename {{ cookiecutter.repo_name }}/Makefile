.PHONY: all create-stack delete-stack getdns stack sync

all: sync

create-stack:
	aws cloudformation create-stack \
		--stack-name `echo $(DOMAIN) | tr "." "-"` \
		--template-body file://aws_scripts/cloudformation_build.json \
		--parameters file://aws_scripts/cloudformation_parameters.json

stack:
	aws cloudformation update-stack \
		--stack-name `echo $(DOMAIN) | tr "." "-"` \
		--template-body file://aws_scripts/cloudformation_build.json \
		--parameters file://aws_scripts/cloudformation_parameters.json

getdns:
	@aws route53 list-resource-record-sets \
	--hosted-zone-id `aws route53 list-hosted-zones \
		| jq ".HostedZones[] | select(.Name == \"$(DOMAIN).\") | .Id" \
		| tr -d \" \
		| cut -d"/" -f 3` \
	| jq ".[][] | select(.Type == \"NS\") | .ResourceRecords[][]" \
	| tr -d \" \
	| sed 's/.$$//'

sync:
	aws s3 sync build2 s3://$(DOMAIN) \
		--delete \
		--exclude "*.DS_Store" \
		--exclude "*.git/*" \
		--cache-control max-age=604800

delete-stack:
	aws cloudformation delete-stack \
		--stack-name `echo $(DOMAIN) | tr "." "-"`
