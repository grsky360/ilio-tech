#/bin/sh

DEFAULT_HOST=ilio.tech
DEFAULT_USER=root
DEFAULT_ID_RSA=~/.ssh/id_rsa
read -p 'Enter host name: (ilio.tech) ' HOST
read -p 'Enter host user name: (root) ' USER
read -p 'Enter id_rsa path: (~/.ssh/id_rsa) ' ID_RSA

if [ -z "${HOST}" ];then
	HOST=$DEFAULT_HOST
fi
if [ -z "${USER}" ];then
	USER=$DEFAULT_USER
fi
if [ -z "${ID_RSA}" ];then
	ID_RSA=$DEFAULT_ID_RSA
fi

ssh -i ${ID_RSA} ${USER}@${HOST} "cd /data0/app/ilio-tech; git fetch; git reset --hard origin/master"