#!/bin/sh
set -e

function fail {
  echo "$@" 1>&2
  exit 1
}

if [ "${NTP_MAXOFFSET}" -ne "0" ]; then
  ./clockoffset -ntpserver "${NTP_SERVER}" \
    -format h \
    -limit "${NTP_MAXOFFSET}" || fail "Error: timedrift exceeds ${NTP_MAXOFFSET}ms"
fi

if [[ -z "${OTP_SECRET}" ]]; then
  echo "WARNING: OTP_SECRET is undefined. Will not define SSHPASS!"
else
  export SSHPASS="${OTP_PREFIX}$(oathtool -b --totp $OTP_SECRET)${OTP_SUFFIX}"
fi

if [[ -n "${DEBUG}" ]]; then
  echo "DEBUG: SSHPASS is ${SSHPASS}"
fi

exec "$@"
