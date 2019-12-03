# Docker sshpass-oathtool
Alpine based image provides ssh, oathtool (for generating TOTP tokens) and sshpass (a noninteractive ssh password provider) for automated ssh logins using time-based one-time password authentication.

## Environment variables

| Var                         | Description        |
|-----------------------------|--------------------|
| OTP_SECRET<br> **Required** | TOTP seecret (SHA) |
| OTP_PREFIX<br> *Optional*   | Prefix for SSHPASS |
| OTP_SUFFIX<br> *Optional*   | Suffix for SSHPASS |
| SSHPASS<br> *Generated*     | Exposed at entrypoint. To be used with `sshpass -e`|

## Usage

    docker run \
      --rm \
      -e OTP_SECRET="" \
      jb5r/sshpass-oathtool:latest \
      sshpass -e ssh user@host <command>
