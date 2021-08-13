FROM golang:alpine
RUN apk add git

ENV GO111MODULE=off
RUN go get github.com/beevik/ntp
RUN go get github.com/jbrunner/clockoffset
WORKDIR /go/src/github.com/jbrunner/clockoffset/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o clockoffset .

FROM alpine:latest
RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  sshpass \
  oath-toolkit-oathtool
COPY entrypoint.sh /entrypoint.sh
COPY --from=0 /go/src/github.com/jbrunner/clockoffset/clockoffset /
RUN chmod +x /entrypoint.sh /clockoffset
ENV OTP_PREFIX=""
ENV OTP_SECRET=""
ENV OTP_SUFFIX=""
# hardcoded for backward compatibility. Will be removed in a future release
ENV NTP_SERVER="time.google.com"
ENV NTP_MAXOFFSET="20000"
ENTRYPOINT ["/entrypoint.sh"]
