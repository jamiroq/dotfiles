ROOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
TARGET   := $(wildcard .??*)
EXCLUDES := .DS_Store .git .gitignore
DOTFILES := $(filter-out $(EXCLUDES), $(TARGET))

.PHONY: deploy list init update

deploy: ## Deployment dot files in your home directory
	@echo 'Creating symbolic link for dot file'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

list: ## Show the dot files
	@$(foreach val, $(DOTFILES), /bin/ls -d $(val);)

update: ## Update this repository
	@echo 'Update dotfiles repository'
	git pull origin master

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
