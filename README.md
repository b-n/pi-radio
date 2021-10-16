# PI-radio

Cobbling together some docker images to run a radio on a Raspberry PI - streaming to an RTMP server

Why?

Because maybe you want to broadcast your music to multiple locations at once (anything that can listen to rtmp at least)

## Building

(Tested on linux)

Make sure you have the correct buildx platforms available and a buildx instance for multi-platform builds (run once)

    make install-buildx-emus
    make docker-buildx-instance

Build and push images to docker hub:

    make all
