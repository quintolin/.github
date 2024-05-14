SHELL := /bin/sh
.POSIX: # enable POSIX compatibility
.SUFFIXES: # no special suffixes
.DEFAULT_GOAL := default

DOCKER_USER_ARGS = --user=$$(id --user):$$(id --group)
DOCKER_IMAGE_EDITORCONFIG_CHECKER = mstruebing/editorconfig-checker:v3.0.1

# dummy entry to force make to do nothing by default
.PHONY: default
default:
	@echo "Please choose target explicitly."

# git helper: push current branch to configured remotes
.PHONY: git_push_current_branch
git_push_current_branch:
	git remote | xargs -L1 git push --verbose

# git helper: push all tags to all configured remotes
.PHONY: git_push_tags
git_push_tags:
	git remote | xargs -L1 git push --verbose --tags

# lint all files against EditorConfig settings
.PHONY: lint_editorconfig
lint_editorconfig:
	docker container run --rm ${DOCKER_USER_ARGS} --volume=$$PWD:/check ${DOCKER_IMAGE_EDITORCONFIG_CHECKER}
