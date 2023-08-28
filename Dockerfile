ARG BASE_IMAGE

FROM golang:1.20 as builder
WORKDIR /go/src/DataDog/container-object-storage-interface-controller
ADD . .
ENV GOFLAGS="-buildvcs=false"
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="COSI Controller"

COPY --from=builder /go/src/DataDog/container-object-storage-interface-controller/bin/controller-manager controller-manager

ENTRYPOINT ["/controller-manager"]
