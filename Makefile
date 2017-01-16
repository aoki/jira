NAME			:= jira
VERSION		:= v0.1.0
REVISION	:= $(shell git rev-parse --short HEAD)

SRCS		:= $(shell find . -type f -name '*.go')
LDFLAGS	:= -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""


.PHONY: glide
glide:
ifeq ($(shell command -v glide 2> /dev/null),)
	curl https://glide.sh/get | sh
endif

.PHONY: init
init:
	glide create

.PHONY: deps
deps: glide
	glide install -v

bin/$(NAME): $(SRCS)
	which go
	go version
	go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o bin/$(NAME)

.PHONY: install
install:
	go install $(LDFLAGS)

.PHONY: clean
clean:
	rm -rf bin/*
	rm -rf vendor/*

.PHONY: test
test:
	go test -cover -v `glide novendor`
