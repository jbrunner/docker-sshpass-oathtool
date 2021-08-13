# Docker sshpass-oathtool
Alpine based image provides ssh, oathtool (for generating TOTP tokens) and sshpass (a noninteractive ssh password provider) for automated ssh logins using time-based one-time password authentication.

## Environment variables

| Var                         | Description        |
|-----------------------------|--------------------|
| OTP_SECRET<br> **Required** | TOTP seecret (SHA) |
| OTP_PREFIX<br> *Optional*   | Prefix for SSHPASS |
| OTP_SUFFIX<br> *Optional*   | Suffix for SSHPASS |
| SSHPASS<br> *Generated*     | Exposed at entrypoint. To be used with `sshpass -e`|
| NTP_SERVER<br> *Required*   | For backward compatibility default is set to time.google.com. This will be removed in a future release |
| NTP_MAXOFFSET<br> *Optional*| Exit if time offset is > NTP_MAXOFFSET (ms). Set to Zero to disable ntp time comparison. Default: 20000 |

## Usage

    docker run \
      --rm \
      -e OTP_SECRET="" \
      jb5r/sshpass-oathtool:latest \
      sshpass -e ssh user@host <command>
