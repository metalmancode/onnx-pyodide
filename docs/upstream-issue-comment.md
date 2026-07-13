# Draft comment for pyodide/pyodide-recipes#216

Do not post this draft until the public repository URL is final.

---

I have a reproducible experimental ONNX 1.15.0 recipe working with Pyodide
0.29.4 / Python 3.13 (`pyodide-build` 0.34.4).

The port handles three cross-compilation points:

- it uses a host-native `protoc` while compiling the Protobuf runtime to Wasm;
- it supplies the target Python headers from Pyodide's cross-build
  environment; and
- it removes ONNX's ELF-only `--exclude-libs` linker option.

I also tested the complete browser path, not only `import onnx`:

1. train `sklearn.linear_model.LogisticRegression` in Pyodide;
2. convert it with `skl2onnx` 1.19.1;
3. validate and serialize with ONNX 1.15.0; and
4. execute the generated 379-byte model with ONNX Runtime Web 1.22.0.

The public recipe, patches, structural check, and browser proof are here:
https://github.com/metalmancode/onnx-pyodide

The locally reproduced wheel SHA-256 is:
`2a827f6e2649395743afac49186343ca9221f48a1c67cce300cd019a7f448cd4`

This work came from the browser-local ML pipeline used in MLDeck:
https://mldeck.com/

For related browser-ML integration or collaboration:
contact@mldeck.com

I would be happy to adapt the recipe to the repository's current conventions.
Would maintainers prefer a pull request with this proven ONNX 1.15 version set,
or an update to a newer ONNX release first?
