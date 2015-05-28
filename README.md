# Docker Utils

A collection of scripts to help wrangle Docker.

Most useful when running various build tests to help conserve space.

### Moving Docker DeviceMapper to another drive
It sometimes helps to have the Devicemapper files on another drive, or somewhere besides your /root partition.

To move the Devicemapper directory:
```bash
sudo su
#Stop Docker
systemctl stop docker.service
#Move Dockerfiles to another storage location
cp -R /var/lib/docker/ /media/Storage/Dockerfiles
#Set the permissions
chmod -R 0700 /media/Storage/Dockerfiles
#Make a backup of the original files, just in case
mv /var/lib/docker/ /var/lib/docker.backup
#Link the external location to the old default location
ln -s /media/Storage/Dockerfiles/ /var/lib/docker
#Check for any errors and repair devicemapper metadata if needed.
#This will fix the errors like:
#Error response from daemon: Error running DeviceCreate (createSnapDevice) dm_task_run failed errors
thin_check /home/_varlibdockerfiles/devicemapper/devicemapper/metadata
thin_check --clear-needs-check-flag /home/_varlibdockerfiles/devicemapper/devicemapper/metadata
#Start Docker again
systemctl start docker.service
```
Once you're done, try to build a container. If all works well, then you can delete the backup:
```bash
sudo rm -Rf /var/lib/docker.backup
```
