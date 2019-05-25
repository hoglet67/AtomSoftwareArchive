#!/bin/bash -e

# Copy all the files into to right place in the archive directory
./scripts/prepare_archive.sh

# Generate the menus and distribution packages
./scripts/rebuild_archive.sh $*
