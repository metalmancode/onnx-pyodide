#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import zipfile
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("wheel", type=Path)
    args = parser.parse_args()

    wheel = args.wheel.resolve()
    if not wheel.is_file():
        raise SystemExit(f"Wheel not found: {wheel}")

    with zipfile.ZipFile(wheel) as archive:
        names = archive.namelist()
        extensions = [
            name
            for name in names
            if name.startswith("onnx/onnx_cpp2py_export") and name.endswith(".so")
        ]
        if len(extensions) != 1:
            raise SystemExit(f"Expected one ONNX extension, found: {extensions}")

        extension = archive.read(extensions[0])
        if extension[:4] != b"\x00asm":
            raise SystemExit("The ONNX extension is not a WebAssembly module")
        if b"PyInit_onnx_cpp2py_export" not in extension:
            raise SystemExit("The CPython module export is missing")
        if b"mldeck.com" in extension:
            raise SystemExit("The community wheel must not contain a domain lock")
        if any(name.startswith("onnx/backend/test/") for name in names):
            raise SystemExit("Upstream backend tests should be removed from the wheel")

    digest = hashlib.sha256(wheel.read_bytes()).hexdigest()
    print(f"wheel={wheel.name}")
    print(f"sha256={digest}")
    print(f"wasm_extension={extensions[0]}")


if __name__ == "__main__":
    main()

