#!/usr/bin/env bash
curl -H "Content-Type: application/json" --data "{'docker_tag': '${DOCKER_IMAGE_TAG}'}" -X POST "https://registry.hub.docker.com/u/${DOCKER_IMAGE_NAME}/trigger/${DOCKER_HUB_TRIGGER_TOKEN}/"
