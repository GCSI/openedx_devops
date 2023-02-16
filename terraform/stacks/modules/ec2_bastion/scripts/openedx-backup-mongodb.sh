#!/bin/bash
#---------------------------------------------------------
# written by: lawrence mcdaniel
#             https://lawrencemcdaniel.com
#             https://blog.lawrencemcdaniel.com
#
# date:       sep-2022
# usage:      backup MongoDB data stores
#             combine into a single tarball, store in "backups" folders in user directory
#
# reference:  https://github.com/edx/edx-documentation/blob/master/en_us/install_operations/source/platform_releases/ginkgo.rst
#
# mongo 'mongodb://${MONGODB_HOST}:27017'
#---------------------------------------------------------

S3_BUCKET="codlp-global-staging-backup"

BACKUPS_DIRECTORY="/home/ubuntu/backups/"
WORKING_DIRECTORY="/home/ubuntu/backup-tmp/"
NUMBER_OF_BACKUPS_TO_RETAIN="3"
NOW="$(date +%Y%m%dT%H%M%S)"

#------------------------------------------------------------------------------
# retrieve the mongo admin credentials from k8s secrets. Sets the following environment variables:
#
# MONGODB_ADMIN_PASSWORD: *******
# MONGODB_ADMIN_USERNAME: admin
# MONGODB_HOST: mongodb.live.global-communications-academy.com
# MONGODB_PORT: "27017"
#
#------------------------------------------------------------------------------
$(ksecret.sh mongodb-admin codlp-global-live)

#Check to see if a working folder exists. if not, create it.
if [ ! -d ${WORKING_DIRECTORY} ]; then
    mkdir ${WORKING_DIRECTORY}
    echo "created backup working folder ${WORKING_DIRECTORY}"
fi

#Check to see if anything is currently in the working folder. if so, delete it all.
if [ -f "$WORKING_DIRECTORY/*" ]; then
  sudo rm -r "$WORKING_DIRECTORY/*"
fi

#Check to see if a backups/ folder exists. if not, create it.
if [ ! -d ${BACKUPS_DIRECTORY} ]; then
    mkdir ${BACKUPS_DIRECTORY}
    echo "created backups folder ${BACKUPS_DIRECTORY}"
fi


cd ${WORKING_DIRECTORY}

# Begin Backup Mongo
#------------------------------------------------------------------------------------------------------------------------

echo "Backing up MongoDB"
mongodump --host ${MONGODB_HOST} --out mongo-dump-${NOW}
echo "Done backing up MongoDB"

#Tarball all of our backup files
echo "Compressing backups into a single tarball archive"
tar -czf ${BACKUPS_DIRECTORY}openedx-mongo-${NOW}.tgz mongo-dump-${NOW}
sudo chown ubuntu ${BACKUPS_DIRECTORY}openedx-mongo-${NOW}.tgz
sudo chgrp ubuntu ${BACKUPS_DIRECTORY}openedx-mongo-${NOW}.tgz
echo "Created tarball of backup data openedx-mongo-${NOW}.tgz"
# End Backup Mongo
#------------------------------------------------------------------------------------------------------------------------

#Prune the Backups/ folder by eliminating all but the 30 most recent tarball files
echo "Pruning the local backup folder archive"
if [ -d ${BACKUPS_DIRECTORY} ]; then
  cd ${BACKUPS_DIRECTORY}
  ls -1tr | head -n -${NUMBER_OF_BACKUPS_TO_RETAIN} | xargs -d '\n' rm -f --
fi

#Remove the working folder
echo "Cleaning up"
sudo rm -r ${WORKING_DIRECTORY}

echo "Sync backup to AWS S3 backup folder"
aws s3 sync --delete ${BACKUPS_DIRECTORY} s3://${S3_BUCKET}/backups
echo "Done!"
