#!/usr/bin/env bash
curl -H "Content-Type: application/json" --data '{"docker_tag": "alpine"}' -X POST https://registry.hub.docker.com/u/unblibraries/nginx-php/trigger/${DOCKER_HUB_TRIGGER_TOKEN}/
