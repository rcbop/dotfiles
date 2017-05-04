#!/bin/bash
# mantainer rogerio.c.peixoto@accenture.com
# 20/07/2016
#
# Cleanup jenkins docker containers
#

##
# Declaring functions
##
function removeExitedContainers() {
  EXITED_CONTAINERS_COUNT=`docker ps -q -f status=exited | tail -n +2 | wc -l`
  EXITED_CONTAINERS=$(docker ps -a -q -f status=exited)

  if [ $EXITED_CONTAINERS_COUNT -gt 0 ]; then
    echo -e '\n>>> Removing exited containers'
    docker rm $EXITED_CONTAINERS
  else
    echo -e '\n>>> There are currently no exited containers'
  fi

  EXITED_CONTAINERS_COUNT=`echo $EXITED_CONTAINERS_COUNT | sed -e 's/^[ \t]*//'`
}

function removeDanglingImages() {
  DANGLING_IMAGES=$(docker images --filter dangling=true -q)
  DANGLING_IMAGES_COUNT=`docker images --filter dangling=true -q | tail -n +2 | wc -l`

  if [ $DANGLING_IMAGES_COUNT -gt 0 ]; then
    echo -e '\n>>> Removing dangling images'
    docker rmi $DANGLING_IMAGES
  else
    echo -e '\n>>> There are currently no dangling images'
  fi

  DANGLING_IMAGES_COUNT=`echo $DANGLING_IMAGES_COUNT | sed -e 's/^[ \t]*//'`
}

function removeUnusedVolumes() {
  echo -e '\n>>> Removing Unused Volumes'
  docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
}

function currentImagesCount() {
  CURRENT_IMAGES_COUNT=`docker images | tail -n +2 | wc -l | sed -e 's/^[ \t]*//'`
}

function diskSpaceUsage() {
  local disk_usage=`df -h | tail -n +2 | head -n1 | awk '{ print $5 }' | sed -e "s/%//g" | sed -e 's/^[ \t]*//'`
  echo "$disk_usage"
}

function calculateCleanedSpace() {
  disk_before=`echo $1 | sed -e "s/%//g"`
  disk_after=`echo $2 | sed -e "s/%//g"`
  return $((disk_before - disk_after))
}

##
# Main script
##
echo '#############################'
echo '## Starting docker cleanup ##'
echo '#############################'

# getting current system usage percentage before cleanup
DISK_SPACE_USAGE_BEFORE=`diskSpaceUsage`
echo "Disk space used before cleanup: $DISK_SPACE_USAGE_BEFORE%"

removeUnusedVolumes

removeExitedContainers
echo "Cleaned containers: $EXITED_CONTAINERS_COUNT"

removeDanglingImages
echo "Cleaned images: $DANGLING_IMAGES_COUNT"

# breakline
echo

# getting current system usage percentage after cleanup
DISK_SPACE_USAGE_AFTER=$(diskSpaceUsage)
echo "Disk space used after cleanup: $DISK_SPACE_USAGE_AFTER%"

# counting current docker images
currentImagesCount
echo "Current images: $CURRENT_IMAGES_COUNT"

# calculate disk space cleaned percentage
DISK_SPACE_CLEANED=$((DISK_SPACE_USAGE_BEFORE-DISK_SPACE_USAGE_AFTER))
DISK_SPACE_CLEANED="$DISK_SPACE_CLEANED%"

# cleaning previous values
rm -f env.properties

echo "-----------------------------"
# exporting as properties for Jenkins envInject plugin
echo CURRENT_IMAGES_COUNT=$CURRENT_IMAGES_COUNT >> env.properties
echo CLEANED_IMAGES_COUNT=$DANGLING_IMAGES_COUNT >> env.properties
echo CLEANED_CONTAINERS_COUNT=$EXITED_CONTAINERS_COUNT >> env.properties
echo DISK_SPACE_CLEANED=$DISK_SPACE_CLEANED >> env.properties

# debug
cat env.properties
