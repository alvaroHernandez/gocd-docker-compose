#!/usr/bin/env bash
if [ $# -ne 1 ]
  then
    echo "Usage ./start.sh <REPOSITORY_URL>"
    exit 1
fi

REPOSITORY_URL="$1"

GO_SERVER_DATA_DIR=./go/server/resources
GO_AGENT_DATA_DIR=./go/agent/resources

HOME_DIR=home-go-dir
SSH_KEYS_DIR=.ssh

GO_SERVER_HOME_DIR=$GO_SERVER_DATA_DIR/$HOME_DIR
GO_AGENT_HOME_DIR=$GO_AGENT_DATA_DIR/$HOME_DIR

GO_SERVER_SSH_KEYS_DIR=$GO_SERVER_HOME_DIR/$SSH_KEYS_DIR
GO_AGENT_SSH_KEYS_DIR=$GO_AGENT_HOME_DIR/$SSH_KEYS_DIR

echo "Seting Up Docker based GOCD Pipeline for repository: $1"

echo "Preparing data folders"
mkdir -p $GO_SERVER_DATA_DIR/godata/config
mkdir -p $GO_SERVER_DATA_DIR/home-go-dir
mkdir -p $GO_SERVER_HOME_DIR/$SSH_KEYS_DIR

mkdir -p $GO_AGENT_DATA_DIR/godata
mkdir -p $GO_AGENT_DATA_DIR/home-go-dir
mkdir -p $GO_AGENT_HOME_DIR/$SSH_KEYS_DIR

echo "Sedding cruise-config.xml with github repo..."
sed 's$REPOSITORY_URL$'$REPOSITORY_URL'$g' ./cruise-config.xml > ./go/server/resources/godata/config/cruise-config.xml

REPOSITORY_HOST=`echo "$REPOSITORY_URL" | sed 's/.*\@\(.*\)\:.*/\1/'`

SSH_CONFIG_FILE=$GO_SERVER_SSH_KEYS_DIR/config
SSH_KEY_FILE=$GO_SERVER_SSH_KEYS_DIR/$REPOSITORY_HOST

echo "Creating SSH config file for $REPOSITORY_HOST"

echo "Host $REPOSITORY_HOST"                       > $SSH_CONFIG_FILE
echo "    User git"                         >> $SSH_CONFIG_FILE
echo "    HostName $REPOSITORY_HOST"              >> $SSH_CONFIG_FILE
echo "    StrictHostKeyChecking no"         >> $SSH_CONFIG_FILE
echo "    IdentityFile /home/go/.ssh/$REPOSITORY_HOST"       >> $SSH_CONFIG_FILE

echo "Generating SSH key at $SSH_KEY_FILE"
ssh-keygen -t rsa -f $SSH_KEY_FILE -P ''

cp $SSH_CONFIG_FILE $GO_AGENT_SSH_KEYS_DIR/
cp $SSH_KEY_FILE $GO_AGENT_SSH_KEYS_DIR/
cp $SSH_KEY_FILE.pub $GO_AGENT_SSH_KEYS_DIR/

echo "SSH generated and copied into Server and Agent home directory"
echo "Please copy add the public key to your repository"
cat $SSH_KEY_FILE.pub

echo "------------------"

echo "Creating containers"
docker-compose up --build -d
