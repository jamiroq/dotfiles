ROOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
TARGET   := $(wildcard .??*)
EXCLUDES := .DS_Store .git
DOTFILES := $(filter-out $(EXCLUDES), $(TARGET))

.PHONY: deploy list init update

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

list:
	@$(foreach val, $(DOTFILES), /bin/ls $(val);)

update:
	git pull origin master
