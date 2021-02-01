# Build image
########################
FROM golang:1.15.7-alpine3.12 as builder

WORKDIR /var/tmp/app

RUN apk add git

# copy artifacts into the container
ADD ./main.go ./main.go
ADD ./go.mod ./go.mod
ADD ./go.sum ./go.sum
ADD ./pkg ./pkg

# Build the app
RUN go build -o .build/app .

# Final image
########################
FROM alpine:3.13.1

WORKDIR /opt/app

COPY --from=builder /var/tmp/app/.build/app .

CMD [ "./app" ]
