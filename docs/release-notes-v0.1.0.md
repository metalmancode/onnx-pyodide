# ONNX for Pyodide v0.1.0

First public experimental release of the reproducible ONNX 1.15.0 build for
Pyodide 0.29.4 / Python 3.13.

## Included

- recipe-based build with `pyodide-build` 0.34.4;
- host-native `protoc` support during cross-compilation;
- target Python header and Emscripten linker fixes;
- compact WebAssembly wheel with the backend test corpus removed;
- structural wheel verification; and
- an end-to-end browser proof covering scikit-learn training, `skl2onnx`
  conversion, ONNX checking, serialization, and ONNX Runtime Web inference.

## Verified artifact

```text
onnx-1.15.0-cp313-cp313-pyemscripten_2025_0_wasm32.whl
sha256: 2a827f6e2649395743afac49186343ca9221f48a1c67cce300cd019a7f448cd4
```

This is an experimental compatibility release, not a claim of support for
every ONNX operator, estimator, browser, or operating system.

The work was created by Gholamreza Rashidi Ardestani from the browser-local
ONNX export technology used in [MLDeck](https://mldeck.com/).

For browser-ML integration or collaboration: contact@mldeck.com
