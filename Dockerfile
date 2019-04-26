FROM golang:1.12-alpine3.9 as builder

WORKDIR /go/src/app

COPY . .

RUN apk update

RUN apk add git

RUN cd cmd; GO111MODULE=on CGO_ENABLED=0 go install ./...

FROM alpine:3.9

COPY --from=builder /go/bin /usr/local/bin

RUN addgroup -S loopd && adduser -S loopd -G loopd

USER loopd

CMD [ "loopd" ]