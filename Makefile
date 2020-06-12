default: help

.PHONY: xenial
xenial: ## Build AMI for Ubuntu 16.04 ("Xenial") LTS
	@cd xenial && packer validate template.json
	@cd xenial && packer build template.json

.PHONY: bionic
bionic: ## Build AMI for Ubuntu 18.04 ("Bionic") LTS
	@cd bionic && packer validate template.json
	@cd bionic && packer build template.json

.PHONY: focal
focal: ## Build AMI for Ubuntu 20.04 ("Focal") LTS
	@cd focal && packer build template.pkr.hcl

.PHONY: help
help: ## Display this information. Default target.
	@echo "Valid targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
