#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}"

if ! command -v pyodide >/dev/null 2>&1; then
  echo "pyodide-build is not installed in the active environment." >&2
  echo "Create a Python 3.13 virtual environment and run:" >&2
  echo "  python -m pip install -r requirements-build.txt" >&2
  exit 1
fi

if [ -n "${PROTOC:-}" ]; then
  PROTOC_BIN="${PROTOC}"
else
  "${ROOT}/scripts/fetch-protoc.sh" "${ROOT}/.tools/protoc"
  PROTOC_BIN="${ROOT}/.tools/protoc/bin/protoc"
fi

if [ "$("${PROTOC_BIN}" --version)" != "libprotoc 22.3" ]; then
  echo "Expected protoc 22.3 at ${PROTOC_BIN}" >&2
  exit 1
fi

export PROTOC="${PROTOC_BIN}"
export PYODIDE_XBUILDENV_PATH="${PYODIDE_XBUILDENV_PATH:-${ROOT}/.pyodide-xbuildenv-0.34.4}"

pyodide build-recipes-no-deps onnx \
  --recipe-dir "${ROOT}/packages" \
  --force-rebuild

echo "Built wheel:"
find "${ROOT}/packages/onnx/dist" -maxdepth 1 -name '*.whl' -print
