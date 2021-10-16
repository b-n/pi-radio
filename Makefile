PI_ARCH=linux/arm64/v8
DOCKER_USER=$(shell docker info | sed '/Username:/!d;s/.* //')

all: install-buildx-emus mopidy-image

install-buildx-emus:
	docker run --privileged --rm tonistiigi/binfmt --install $(PI_ARCH)

mopidy-image:
	docker buildx build --platform=$(PI_ARCH) --tag $(DOCKER_USER)/mopidy:latest -f Dockerfile.mopidy .

nginx-rtmp-image:
	cd nginx-rtmp-docker && \
	docker buildx build --platform=$(PI_ARCH) --tag $(DOCKER_USER)/nginx-rtmp:latest .

push-images:
	docker image push $(DOCKER_USER)/nginx-rtmp:latest
	docker image push $(DOCKER_USER)/mopidy:latest

