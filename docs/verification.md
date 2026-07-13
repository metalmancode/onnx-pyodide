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

This record proves the documented version set on the stated host. It is not a
claim that every ONNX operator, estimator, browser, or operating system is
supported.
