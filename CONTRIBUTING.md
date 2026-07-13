# Contributing

Contributions that improve reproducibility, compatibility, tests, or the
upstream recipe are welcome.

## Before opening a pull request

1. Build with the documented version set in `README.md`.
2. Run the structural wheel check.
3. Run the browser proof and include the final `PASS` line in the pull request.
4. Describe any version, patch, or toolchain changes explicitly.

Please do not add MLDeck product code, customer data, credentials, service
configuration, analytics, or domain-specific restrictions. This repository is
the generic community port only.

## Reporting build failures

Include the operating system, CPU architecture, Python version,
`pyodide-build` version, `protoc --version`, the failing command, and the last
relevant part of `packages/onnx/build.log`.

By contributing, you agree that your contribution is licensed under Apache
License 2.0.
