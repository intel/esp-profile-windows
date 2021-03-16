#!/bin/sh

# Copyright (C) 2021 Intel Corporation
# SPDX-License-Identifier: BSD-3-Clause

profiledir="$(dirname "$0")"

command="cd /tmp && apk add wget unzip && \
  mkdir syslinux && \
  wget -O syslinux-5.00.zip https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-5.00.zip && \
  unzip syslinux-5.00.zip -d syslinux && \
  cp syslinux/memdisk/memdisk memdisk && \
  chmod a+x memdisk && \
  rm -rf syslinux-5.00.zip syslinux && cd -"

if [ ! -z "${http_proxy}" ]; then
  docker run --rm --env http_proxy=${http_proxy} --env https_proxy=${https_proxy} --env HTTP_PROXY=${http_proxy} --env HTTPS_PROXY=${https_proxy} --env NO_PROXY=localhost,127.0.0.1 -v $profiledir:/tmp alpine:3.9 /bin/sh -c "$command"
else
  docker run --rm -v $profiledir:/tmp alpine:3.9 /bin/sh -c "$command"
fi 
