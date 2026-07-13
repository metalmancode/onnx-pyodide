#!/usr/bin/env bash
set -euo pipefail

VERSION="22.3"
DESTINATION="${1:-.tools/protoc}"

case "$(uname -s)-$(uname -m)" in
  Darwin-x86_64) ASSET="osx-x86_64" ;;
  Darwin-arm64) ASSET="osx-aarch_64" ;;
  Linux-x86_64) ASSET="linux-x86_64" ;;
  Linux-aarch64|Linux-arm64) ASSET="linux-aarch_64" ;;
  *)
    echo "Unsupported host: $(uname -s)-$(uname -m)" >&2
    exit 1
    ;;
esac

mkdir -p "${DESTINATION}"
ARCHIVE="${DESTINATION}/protoc-${VERSION}.zip"
URL="https://github.com/protocolbuffers/protobuf/releases/download/v${VERSION}/protoc-${VERSION}-${ASSET}.zip"

if [ ! -x "${DESTINATION}/bin/protoc" ]; then
  curl --fail --location --silent --show-error "${URL}" --output "${ARCHIVE}"
  unzip -q -o "${ARCHIVE}" -d "${DESTINATION}"
  rm -f "${ARCHIVE}"
fi

"${DESTINATION}/bin/protoc" --version

