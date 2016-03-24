#!/bin/bash


Backup_Home="/vagrant/src/backup/nginx"
Backup_Name=sites-$(date +"%Y%m%d%H%M%S").tar.gz

if [ ! -d ${Backup_Home} ]; then
    mkdir -p ${Backup_Home}
fi


echo "Backup nginx files..."
tar -zcf ${Backup_Home}/${Backup_Name} -C /usr/local/etc/ nginx

if [ -f ${Backup_Home}/${Backup_Name} ]
then
    cp ${Backup_Home}/${Backup_Name} ${Backup_Home}/latest.tar.gz
fi

echo "complete."