#!/bin/sh

# create the cloudera repo 

if [[ ! -f "/etc/yum.repos.d/cloudera-cdh3u4.repo" ]]; then
	cat > /etc/yum.repos.d/cloudera-cdh3u4.repo <<EOF
[cloudera-cdh3]
name=Cloudera's Distribution for Hadoop, Version 3
mirrorlist=http://archive.cloudera.com/redhat/cdh/3u4/mirrors
gpgcheck=1
gpgkey=http://archive.cloudera.com/redhat/cdh/RPM-GPG-KEY-cloudera
EOF
fi
