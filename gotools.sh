curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b /home/simon/codez/go/bin v2.2.0
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /home/simon/codez/go/bin v1.23.1
curl -L https://git.io/misspell | bash
go get github.com/jgautheron/goconst/cmd/goconst
go get github.com/gordonklaus/ineffassign
