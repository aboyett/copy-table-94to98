COPY_TABLE_SRC := $(shell find copy-table -type f)
DEPENDENCY_FIX_SRC := $(shell find dependency-fix -type f)
DEPENDENCY_LIB_SRC := $(shell find dependency-lib -type f)
ALL_SRC := $(COPY_TABLE_SRC) $(DEPENDENCY_FIX_SRC) $(DEPENDENCY_LIB_SRC)

GIT_COMMIT := $(shell git rev-parse --short HEAD)
DOCKER_TAG := git-$(GIT_COMMIT)
DOCKER_IMAGE_NAME := quay.io/agb/copy-table-94to98
DOCKER_IMAGE := $(DOCKER_IMAGE_NAME):$(DOCKER_TAG)

default: copy-table.jar

build-image: Dockerfile
	docker build -t $(DOCKER_IMAGE) .

copy-table.jar: build-image $(ALL_SRC)
	docker run --rm -v $(PWD):/src $(DOCKER_IMAGE)

.PHONY: build-image
