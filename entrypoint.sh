#!/bin/sh
set -e

if [[ -z "${OTP_SECRET}" ]]; then
  echo "WARNING: OTP_SECRET is undefined. Will not define SSHPASS!"
else
  export SSHPASS="${OTP_PREFIX}$(oathtool -b --totp $OTP_SECRET)${OTP_SUFFIX}"
fi

if [[ -n "${DEBUG}" ]; then
  echo "DEBUG: SSHPASS is ${SSHPASS}"
fi

exec "$@"
