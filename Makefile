# Day-to-day commands for this repo. Run `make` for the list.

SHELL  := /bin/bash
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HOST   := $(shell hostname -s)
m      ?= sync from $(HOST) $(shell date '+%Y-%m-%d %H:%M')

.DEFAULT_GOAL := help
.PHONY: help setup install dry-run status pull push sync diff

help: ## Show this list
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | \
	  awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36mmake %-8s\033[0m %s\n", $$1, $$2}'
	@echo
	@echo '  push/sync take an optional message:  make push m="add council skill"'

setup: ## First run on a new machine: pull latest, then link everything
	@git pull --ff-only
	@./install.sh

install: ## Create/repair symlinks (safe to re-run)
	@./install.sh

dry-run: ## Show what install would change
	@./install.sh --dry-run

status: ## Show git changes and the state of every link
	@git status --short --branch
	@echo
	@./install.sh --status

diff: ## Show uncommitted changes to configs
	@git --no-pager diff --stat
	@git --no-pager diff

pull: ## Get remote changes and re-link (keeps local edits)
	@git pull --rebase --autostash
	@./install.sh

push: ## Commit all local changes and push them
	@if [ -n "$$(git status --porcelain)" ]; then \
	  git add -A && git commit -q -m "$(m)" && echo "committed: $(m)"; \
	else \
	  echo "nothing to commit"; \
	fi
	@git push -u origin $(BRANCH)

sync: ## Both directions: commit local, pull remote, push, re-link
	@if [ -n "$$(git status --porcelain)" ]; then \
	  git add -A && git commit -q -m "$(m)" && echo "committed: $(m)"; \
	fi
	@git pull --rebase
	@git push -u origin $(BRANCH)
	@./install.sh
