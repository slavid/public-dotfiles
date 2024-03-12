#!/usr/bin/env bash

COMMAND=$(docker inspect -f '{{ .Mounts }}' image-tag-gallery | awk -F ' ' '{print $9}')

echo $COMMAND


