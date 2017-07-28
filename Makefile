COPY_TABLE_SRC := $(shell find copy-table -type f)
DEPENDENCY_FIX_SRC := $(shell find dependency-fix -type f)
DEPENDENCY_LIB_SRC := $(shell find dependency-lib -type f)
ALL_SRC := $(COPY_TABLE_SRC) $(DEPENDENCY_FIX_SRC) $(DEPENDENCY_LIB_SRC)

# git hash is derived solely from the cryptograph hash of the dependencies (Dockerfile)
GIT_HASH := $(shell git ls-tree HEAD | awk '/Dockerfile/ {print $$3}')
DOCKER_TAG := tree-$(GIT_HASH)
DOCKER_IMAGE_NAME := quay.io/agb/copy-table-94to98-builder
DOCKER_IMAGE := $(DOCKER_IMAGE_NAME):$(DOCKER_TAG)

default: copy-table.jar

build-image: Dockerfile
	docker build -t $(DOCKER_IMAGE) .

copy-table.jar: build-image $(ALL_SRC)
	docker run --rm -v $(PWD):/src $(DOCKER_IMAGE)

.PHONY: build-image
