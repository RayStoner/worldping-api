#!/bin/bash
set -x
# Find the directory we exist within
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

: ${GOPATH:="${HOME}/.go_workspace"}
: ${ORG_PATH:="github.com/grafana"}
: ${REPO_PATH:="${ORG_PATH}/grafana"}

if [ ! -z ${CIRCLECI} ] ; then
  : ${CHECKOUT:="/home/ubuntu/${CIRCLE_PROJECT_REPONAME}"}
else
  : ${CHECKOUT:="${DIR}/.."}
fi

export GOPATH

mkdir -p artifacts/bin
cp -a ../conf artifacts/
cp -a ../public artifacts/

bundle install

echo "Linking ${GOPATH}/src/${REPO_PATH} to ${CHECKOUT}"
mkdir -p ${GOPATH}/src/${ORG_PATH}
ln -s ${CHECKOUT} ${GOPATH}/src/${REPO_PATH}

go get github.com/tools/godep

