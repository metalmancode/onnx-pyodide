# Verification record

Date: 2026-07-13

Environment:

- macOS arm64 build host
- Pyodide 0.29.4 / Python 3.13
- pyodide-build 0.34.4
- Emscripten 4.0.9
- host protoc 22.3

## Clean recipe build

Command:

```bash
./scripts/build.sh
```

Result:

```text
Succeeded building package onnx in 150.2 seconds.
onnx-1.15.0-cp313-cp313-pyemscripten_2025_0_wasm32.whl
```

## Structural check

Command:

```bash
python tests/test_wheel_structure.py packages/onnx/dist/*.whl
```

Result:

```text
sha256=2a827f6e2649395743afac49186343ca9221f48a1c67cce300cd019a7f448cd4
wasm_extension=onnx/onnx_cpp2py_export.cpython-313-wasm32-emscripten.so
```

The repacked wheel is approximately 1.7 MB and excludes the upstream backend
test corpus.

## Browser end-to-end proof

The proof was run through the served `demo/` page against the wheel built above.

Result:

```text
ONNX 1.15.0 generated and checked (379 bytes).
Inference outputs: {"label":["1"],"probabilities":[0.1474176049232483,0.8525823950767517]}
PASS: browser-local training → skl2onnx → ONNX → ONNX Runtime Web
```

## Current-repository cloud validation

The recipe submitted in
[`pyodide/pyodide-recipes#620`](https://github.com/pyodide/pyodide-recipes/pull/620)
was also validated against the current repository toolchain. The targeted
GitHub Actions run used the Python 3.14 / Pyodide 314 toolchain, built the ONNX
wheel, and passed the recipe runtime test in Chrome, Firefox, and Node.

Validation run:

<https://github.com/metalmancode/pyodide-recipes/actions/runs/29262798470>

The runtime test creates a small ONNX graph, checks it through the compiled
ONNX checker, serializes it, loads it back, and checks the restored model.

## Current-repository local macOS arm64 reproduction

Date: 2026-07-13

Host and toolchain:

- macOS 26.5.1 on arm64
- host Python 3.14.6
- Pyodide cross-build environment 314.0.2 / target Python 3.14
- pyodide-build 0.36.0
- Emscripten 5.0.3
- CMake 3.31.10
- host protoc 22.3
- Node 20.17.0
- Chrome 150.0.7871.115

The upstream validation recipe pins the Linux x86-64 protoc 22.3 archive for
its Linux CI host. For this macOS reproduction, the official protoc 22.3
macOS arm64 archive was extracted into the recipe's temporary `.protoc`
directory before the build. Its archive SHA-256 was:

```text
79cc15d1b528061ea0a818b0abcf3be1e0bdcb063a0cc999af27974cccdc5cce
```

No recipe source, patch, or test file was changed for the local build. The
temporary host tool was removed afterward, and the pull-request branch was
confirmed clean.

Build command:

```bash
pyodide build-recipes onnx \
  --install \
  --install-dir=/private/tmp/onnx-local-repodata \
  --build-dir=/private/tmp/onnx-local-build \
  --log-dir=/private/tmp/onnx-local-build-logs \
  --n-jobs 1
```

Result:

```text
[1/2] (thread 1) built onnx in 2m 22s
[2/2] (thread 1) built protobuf in 19s
Building packages... 2/2 100% Time elapsed: 0:02:42
```

Generated wheel:

```text
onnx-1.15.0-cp314-cp314-pyemscripten_2026_0_wasm32.whl
size=1586943 bytes
sha256=8ca27415728dae4eae1470dc41494b376037edf6d01f7f60326a992197114bd6
```

The recipe runtime test passed locally in both Node and Chrome:

```text
test_onnx_create_check_and_serialize[node] PASSED
1 passed in 2.90s

test_onnx_create_check_and_serialize[chrome] PASSED
1 passed in 9.84s
```

This record proves the documented version set on the stated host. It is not a
claim that every ONNX operator, estimator, browser, or operating system is
supported.
