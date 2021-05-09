FROM golang

ARG GRPC_VERSION=1.37.0

ARG PROTOC_VERSION=3.16.0

ARG PROTOC_ZIP=protoc-${PROTOC_VERSION}-linux-x86_64.zip

RUN apt update && apt install unzip -y

RUN wget -P /tmp \
  https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${PROTOC_ZIP}

RUN unzip -o /tmp/${PROTOC_ZIP} -d /usr/local bin/protoc

RUN unzip -o /tmp/${PROTOC_ZIP} -d /usr/local 'include/*'

WORKDIR /home

RUN wget https://github.com/grpc/grpc-go/archive/refs/tags/v${GRPC_VERSION}.zip

RUN unzip v${GRPC_VERSION}.zip

WORKDIR /home/grpc-go-${GRPC_VERSION}/examples/helloworld

RUN go get google.golang.org/protobuf/cmd/protoc-gen-go \
         google.golang.org/grpc/cmd/protoc-gen-go-grpc
