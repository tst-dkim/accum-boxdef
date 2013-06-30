#!/bin/sh

# now create the devtoolset repos (note: these should also be in the third
# party RPMs)

# Also, the lexical order of the devtoolset repos does matter
# because otherwise we'll default to the 32-bit libs everywhere
# which is NOT what we want - 64-bit first, 32-bit second

if [[ ! -f "/etc/yum.repos.d/devtoolset-1.1-32.repo" ]]; then
	cat > /etc/yum.repos.d/devtoolset-1.1-32.repo <<EOF
[devtoolset-1.1-32]
name=1.1 devtools for CentOS, 32-bit
baseurl=http://people.centos.org/tru/devtools-1.1/6/i386/RPMS/
gpgcheck=0
EOF
fi

if [[ ! -f "/etc/yum.repos.d/devtoolset-1.1.repo" ]]; then
	cat > /etc/yum.repos.d/devtoolset-1.1.repo <<EOF
[devtoolset-1.1]
name=1.1 devtools for CentOS, 64-bit
baseurl=http://people.centos.org/tru/devtools-1.1/6/x86_64/RPMS/
gpgcheck=0
EOF
fi

# Now install all the compiler libraries and devtoolset packages

yum install -y glibc-devel.i686 libstdc++-devel.i686
# need 32-bit libs alongside the 64-bit ones
yum install -y devtoolset-1.1
yum install -y devtoolset-1.1-gcc-c++.i686 devtoolset-1.1-libstdc++-devel.i686 devtoolset-1.1-libquadmath-devel.i686

