APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=1g0rsv
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
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot2 -ldflags "-X="1g0rsv/kbot2/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}
push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
clean:
	rm -rf kbot2
