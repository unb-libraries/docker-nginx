#!/usr/bin/env bash
# Trigger an image's build on dockerhub. DOCKER_HUB_TRIGGER_TOKEN must be set
# in the Repository's "Environment Variables" on travis-ci.org.
curl -H "Content-Type: application/json" --data "{'docker_tag': '${DOCKER_IMAGE_TAG}'}" -X POST "https://registry.hub.docker.com/u/${DOCKER_IMAGE_NAME}/trigger/${DOCKER_HUB_TRIGGER_TOKEN}/"
