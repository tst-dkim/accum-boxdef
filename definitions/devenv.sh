#!/bin/sh

[ -z $(which wget 2>/dev/null) ] && yum install wget -y
[ -z $(which git 2>/dev/null) ] && yum install git -y
[ -z $(which svn 2> /dev/null) ] && yum install svn -y
[ -z $(which rpmbuild 2>/dev/null) ] && yum install rpm-build -y

if [[ -z $(which java 2>/dev/null) ]]; then
# fetch and install Java 6 (btw, auto-installing Java 7 is easier because a regular RPM is downloaded, not an executable w/ an enclosed RPM)
#	curl -S -k -L -H "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" https://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin -O
	wget -nv --no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin -O /tmp/jdk-6u45-linux-x64-rpm.bin
	chmod +x /tmp/jdk-6u45-linux-x64-rpm.bin
	pushd /tmp
	./jdk-6u45-linux-x64-rpm.bin
	popd
	echo -e '#!/bin/sh

#
# Java JDK
#

JAVA_HOME=${JAVA_HOME:-"/usr/java/default"}
JAVA_CLASSPATH="${JAVA_HOME}/lib"
CLASSPATH=${CLASSPATH:+"${CLASSPATH}:${JAVA_CLASSPATH}"}
CLASSPATH=${CLASSPATH:-"${JAVA_CLASSPATH}"}

JAVA_LD_LIBRARY_PATH="${JAVA_HOME}/jre/lib/amd64"
LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+"${LD_LIBRARY_PATH}:${JAVA_LD_LIBRARY_PATH}"}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-"${JAVA_LD_LIBRARY_PATH}"}
PATH="${PATH}:${JAVA_HOME}/bin"

export JAVA_HOME CLASSPATH LD_LIBRARY_PATH PATH' > /etc/profile.d/java_oracle.sh

	alternatives --install /usr/bin/java java /usr/java/jdk_1.6.0_45/bin/java 21000
	alternatives --install /usr/bin/javac javac /usr/java/jdk_1.6.0_45/bin/javac 21000
fi

# maven
if [[ -z $(which mvn 2>/dev/null) ]]; then
	curl -O http://apache.mirrors.tds.net/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
	tar -zxf apache-maven*.tar.gz -C /usr/share 
	chmod -R ug+rwx  /usr/share/apache-maven-3.0.5
	ln -sf /usr/share/apache-maven-3.0.5/bin/mvn /usr/bin/mvn
	[ -z "${M2_HOME}" ] && echo "export M2_HOME=/usr/share/apache-maven-3.0.5" >> /etc/profile.d/maven.sh && export M2_HOME=/usr/share/apache-maven-3.0.5
fi

# Ant and ant-nodeps
if [[ -z $(which ant 2>/dev/null) ]]; then
	curl -O http://apache.cs.utah.edu/ant/binaries/apache-ant-1.9.1-bin.tar.bz2
	tar -jxf apache-ant-1.9.1-bin.tar.bz2 -C /usr/share/
	chmod -R ug+rwx /usr/share/apache-ant-1.9.1
	[ -z "${ANT_HOME}" ] && echo "ANT_HOME=/usr/share/apache-ant-1.9.1" >> /etc/profile.d/ant.sh && export ANT_HOME=/usr/share/apache-ant-1.9.1
	ln -sf /usr/share/apache-ant-1.9.1/bin/ant /usr/bin/ant
fi

