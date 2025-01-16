FROM golang:alpine
RUN go install github.com/jbrunner/clockoffset@latest

FROM alpine:latest
RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  sshpass \
  oath-toolkit-oathtool
COPY entrypoint.sh /entrypoint.sh
COPY --from=0 /go/bin/clockoffset /usr/bin/clockoffset
RUN chmod +x /entrypoint.sh
ENV OTP_PREFIX=""
ENV OTP_SECRET=""
ENV OTP_SUFFIX=""
ENV NTP_SERVER="time.google.com"
ENV NTP_MAXOFFSET="20000"
ENTRYPOINT ["/entrypoint.sh"]

