#!/bin/sh


if [ -z "$GOPATH" ];then
  echo "Go path is unset."
  exit 1
else
  curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b "$GOPATH"/bin v2.2.0
  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$GOPATH"/bin v1.23.1
  curl -L https://git.io/misspell | sh -s -- -b "$GOPATH"/bin
  go get -u github.com/jgautheron/goconst/cmd/goconst
  go get -u github.com/gordonklaus/ineffassign
  go get -u golang.org/x/tools/...
  go get -u github.com/go-delve/delve/cmd/dlv
fi
