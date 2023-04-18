.PHONY: build clean check lint help


APP := web-example
TAG := latest

all: build

build:
	@go build -o bin/${APP} .

run: build
	@./bin/${APP}

test:
	go test -v ./...

fmt:
	@gofmt -l -w -s .
	@goimports -l -w .

check:
	go vet ./...;true
	gofmt -w .

lint:
	golint ./...

docker-build:
	docker build -t ${APP}:${TAG} .

docker-run:
	docker-compose up -d

clean:
	rm -rf bin/
	go clean -i .

help:
	@echo "make: compile packages and dependencies"
	@echo "make check: run specified go tool [go vet, gofmt]"
	@echo "make lint: golint ./..."
	@echo "make clean: remove object files and cached files"
	@echo "make test: run test file"
	@echo "make run: run the program locally"
	@echo "make docker-build: build the program to a docker image"
	@echo "make docker-run: run the program in a container"