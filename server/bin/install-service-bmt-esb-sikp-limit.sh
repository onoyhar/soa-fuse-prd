#!/bin/bash
SOURCE=bankmantap-esb-core-reversal
GROUPID=core
PATH_SOURCE=/opt/fuse/.m2/id/co/bankmantap/esb/$GROUPID
PATH_BACKUP=/home/admin/backupfuse
DATE=`date +%Y/%m/%d/%H`
mkdir -p $PATH_BACKUP/$DATE
mv -f $PATH_SOURCE/$SOURCE $PATH_BACKUP/$DATE/$SOURCE/

/opt/fuse/bin/client 'osgi:uninstall --force bankmantap-esb-sikp-limit/1.0.0'
/opt/fuse/bin/client 'osgi:install -s mvn:id.co.bankmantap.esb.sikp.limit/bankmantap-esb-sikp-limit/1.0.0'
/opt/fuse/bin/client 'osgi:list | grep "BankMantap ESB SIKP Limit "'
