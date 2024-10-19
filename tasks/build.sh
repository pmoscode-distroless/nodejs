#!/usr/bin/env bash
set -e

VERSIONS=$(ls -d */ | cut -f1 -d'/')
VARIANT=$1

for VERSION in $VERSIONS
do
	echo "Processing $VERSION..."
	ABS_VERSION_FOLDER=$(realpath $VERSION)
	cd $ABS_VERSION_FOLDER

  apko build $VARIANT.yaml $ARTIFACT_NAME-$VERSION:$VARIANT $ARTIFACT_NAME-$VERSION-$VARIANT.tar
  docker load < $ARTIFACT_NAME-$VERSION-$VARIANT.tar
  rm -Rf *.tar
  rm -Rf *.spdx.json
  echo "...done!"
done