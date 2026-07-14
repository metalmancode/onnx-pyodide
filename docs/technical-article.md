# Building ONNX inside the browser with Pyodide

Most browser ONNX examples begin with an existing model. The runtime downloads
the `.onnx` file and executes it. A different problem appears when a Python ML
workflow must create that model inside the browser: `skl2onnx` depends on the
ONNX Python package, and ONNX includes a compiled CPython extension.

This project demonstrates the complete local path:

`browser data → scikit-learn training → skl2onnx conversion → ONNX validation
→ ONNX Runtime Web inference`

No training-data upload is required by the proof. The model is trained,
converted, checked, serialized, and executed in one browser tab.

## Why ONNX is difficult to cross-compile

ONNX's build combines Python, CMake, C++, Protobuf, and generated source files.
That creates a host/target split:

- the build host needs a native `protoc` executable that it can run;
- the Protobuf runtime and ONNX extension must target WebAssembly; and
- CMake must use the target Python headers, not the host interpreter headers.

A target `protoc` cannot run on the build host. The recipe therefore accepts a
host-native `protoc` through the `PROTOC` environment variable while allowing
the linked runtime to be cross-compiled.

ONNX also adds an ELF linker option, `--exclude-libs`, on non-Apple Unix
systems. Emscripten's `wasm-ld` does not accept that option, so the community
recipe removes it. The single-threaded Wasm build defines
`GOOGLE_PROTOBUF_NO_THREAD_SAFETY`.

## Reproduced version set

- Pyodide 0.29.4 / Python 3.13
- pyodide-build 0.34.4
- ONNX 1.15.0
- host protoc 22.3
- skl2onnx 1.19.1
- ONNX Runtime Web 1.22.0

The repository builds a `pyemscripten_2025_0_wasm32` wheel and checks that the
compiled extension has the WebAssembly magic bytes and exports
`PyInit_onnx_cpp2py_export`. The browser proof then trains a logistic regression
model, produces a valid 379-byte ONNX graph, and runs inference with ONNX
Runtime Web.

## Product origin and open-source boundary

The version set was developed while building [MLDeck](https://mldeck.com/), a
browser-local AutoML product. The public repository contains only the generic
port, build recipe, tests, and demonstration. MLDeck's application workflows,
product logic, service configuration, and customer concerns remain separate.

The port and reproducible proof were created by Gholamreza Rashidi Ardestani,
creator and developer of MLDeck.

To discuss browser-local ML integration, a custom Pyodide/Wasm port, or an
MLDeck pilot, contact [contact@mldeck.com](mailto:contact@mldeck.com).

This boundary makes the infrastructure reviewable and reusable while the
product continues to compete on workflow, validation, usability, and support.

## Prior work and next steps

Joseph Rocca previously published an ONNX 1.13 / Python 3.10 browser proof in
[`onnx-pyodide`](https://github.com/josephrocca/onnx-pyodide). This work builds
on the same general direction with a newer Pyodide/Python version set, a
recipe-based build, and an explicit `skl2onnx` end-to-end conversion test.

The original upstream discussion,
[`pyodide/pyodide-recipes#216`](https://github.com/pyodide/pyodide-recipes/issues/216),
was closed after maintainers confirmed that ONNX now publishes Pyodide wheels
from its own repository. The current follow-up is
[`onnx/onnx#8192`](https://github.com/onnx/onnx/pull/8192), which successfully
builds and runtime-tests a Python 3.14 wheel tagged for the 2026 ABI using the
official ONNX workflow.
