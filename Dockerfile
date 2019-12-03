FROM alpine:latest
RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  sshpass \
  oath-toolkit-oathtool
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENV OTP_PREFIX=""
ENV OTP_SECRET=""
ENV OTP_SUFFIX=""
ENTRYPOINT ["/entrypoint.sh"]
