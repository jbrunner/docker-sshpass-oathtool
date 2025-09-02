
FROM golang:alpine AS builder
RUN go install github.com/jbrunner/clockoffset@latest

FROM alpine:latest
RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  sshpass \
  oath-toolkit-oathtool

# Create non-root user and group named 'app'
RUN addgroup -S app && adduser -S app -G app

COPY entrypoint.sh /entrypoint.sh
COPY --from=builder /go/bin/clockoffset /usr/bin/clockoffset
RUN chmod +x /entrypoint.sh && chown app:app /entrypoint.sh /usr/bin/clockoffset

ENV OTP_PREFIX=""
ENV OTP_SECRET=""
ENV OTP_SUFFIX=""
ENV NTP_SERVER="time.google.com"
ENV NTP_MAXOFFSET="20000"

USER app
ENTRYPOINT ["/entrypoint.sh"]

