ROOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
TARGET   := $(wildcard .??*)
EXCLUDES := .DS_Store .git .gitignore .config
DOTFILES := $(filter-out $(EXCLUDES), $(TARGET))
CONFIG_DIR := $(wildcard .config/*)

.PHONY: deploy clean list update help

deploy: deploy_home deploy_config
	@echo 'Creating symbolic link for dot file'

deploy_home: ## Deployment dot files in HOME
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

deploy_config: ## Deployment setting directory in XDG_CONFIG_HOME
	@mkdir -p $(HOME)/.config
	@$(foreach val, $(CONFIG_DIR), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

list: ## Show the dot files
	@echo '[~/home/]'
	@$(foreach val, $(DOTFILES), /bin/ls -d $(val);)
	@echo '[~/home/.config/]'
	@$(foreach val, $(CONFIG_DIR), echo $(val);)

update: ## Update this repository
	@echo 'Update dotfiles repository'
	git pull origin master

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
