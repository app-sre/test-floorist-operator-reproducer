#!/bin/bash
set -ex

login_container_registry() {

    local USER="$1"
    local PASSWORD="$2"
    local REGISTRY="$3"

    podman login "-u=${USER}" "--password-stdin" "$REGISTRY" <<< "$PASSWORD"
}

IMAGE_TAG=$(git rev-parse --short=7 HEAD)

login_container_registry "$QUAY_USER" "$QUAY_TOKEN" "quay.io"

podman build --pull --no-cache -t quay.io/cloudservices/test-floorist-operator-reproducer:$IMAGE_TAG .
