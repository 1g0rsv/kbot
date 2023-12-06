VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

TARGETOS=linux #linux darwin windows
TARGETARCH=arm64 #amd64 arm64



format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v


build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="1g0rsv/kbot2/cmd.appVersion=${VERSION}

clean:
	rm -rf kbot
