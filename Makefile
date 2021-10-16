PROJECT_NAME=pi-radio
ARCH=linux/amd64
PI_ARCH=linux/arm64/v8
BUILD_ARCH=$(ARCH),$(PI_ARCH)

DOCKER_USER=$(shell docker info | sed '/Username:/!d;s/.* //')
DOCKER_TAG=$(shell git describe --tags --abbrev=0)

IMAGES=mopidy nginx-rtmp

.PHONY: all install-buildx-emus docker-buildx-instance

all: $(IMAGES)

install-buildx-emus:
	docker run --privileged --rm tonistiigi/binfmt --install $(PI_ARCH)

docker-buildx-instance:
	docker buildx create --name $(PROJECT_NAME)
	docker buildx use $(PROJECT_NAME)

$(IMAGES):
	cd "$@-docker" && \
	docker buildx build \
	  --platform=$(BUILD_ARCH) \
		--tag "$(DOCKER_USER)/$@:latest" \
		--tag "$(DOCKER_USER)/$@:$(DOCKER_TAG)" \
		--push \
	  .
