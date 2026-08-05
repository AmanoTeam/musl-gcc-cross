#!/bin/bash

declare extra_configure_flags='--with-arch=x86-64 --with-tune=intel'

declare triplet='x86_64-unknown-linux-musl'

repository='https://dl-cdn.alpinelinux.org/alpine/'
release='edge'
resource='main community'
architecture='x86_64'
format='apk'
