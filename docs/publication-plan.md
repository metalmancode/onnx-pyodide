# Publication plan

## Objective

Publish the generic ONNX-for-Pyodide port as a useful technical artifact while
keeping MLDeck's product, workflow, and commercial layers separate. The public
work should create durable attribution, relevant traffic, and qualified
conversations rather than merely releasing an anonymous patch.

## Public boundary

Publish:

- the reproducible Pyodide recipe and generic patches;
- structural checks and an end-to-end browser proof;
- exact supported versions and experimental limitations;
- technical explanation and build instructions; and
- attribution to Gholamreza Rashidi Ardestani and the MLDeck production origin.

Keep outside this repository:

- MLDeck application and AutoML workflow code;
- private UX, packaging, deployment, analytics, and growth logic;
- customer data, schemas, credentials, and service configuration;
- product-specific model validation and commercial support; and
- any domain-locking or entitlement mechanism.

## Recommended sequence

1. Publish this repository under the `metalmancode` account with a focused
   name such as `onnx-pyodide`.
2. Add topics: `onnx`, `pyodide`, `webassembly`, `wasm`, `skl2onnx`,
   `machine-learning`, and `browser-ml`.
3. Create a `v0.1.0` release that records the proven version set and wheel
   SHA-256. Do not commit the large wheel to Git unless a release asset is
   intentionally provided.
4. Publish the technical article from `docs/technical-article.md` on a URL
   controlled by MLDeck, then cross-link the article and repository.
5. Post the prepared comment on `pyodide/pyodide-recipes#216` only after the
   repository and article URLs are stable.
6. Ask maintainers whether they prefer a recipe pull request now or after an
   ONNX version upgrade. Follow their packaging and CI requirements.
7. Share the proof with narrowly relevant communities and link to the live
   demo, repository, and MLDeck—not to a generic home page alone.

## Commercial bridge

The recipe itself is infrastructure and is unlikely to produce meaningful
license revenue. Its commercial value is stronger as evidence of expertise and
as an acquisition channel for:

- browser-local ML and privacy-sensitive inference consulting;
- custom Pyodide/Wasm package ports;
- model export, parity validation, and deployment integration; and
- MLDeck pilots for teams that cannot send raw data to a server.

Each public page should have one concrete call to action: request a browser-ML
integration review or try a focused MLDeck workflow. Track referrals from the
GitHub repository and article separately.

## Thirty-day evidence

Record these weekly:

- repository clones, stars, forks, issues, and unique visitors;
- reactions and maintainer replies on issue 216;
- visits to MLDeck carrying the repository/article referral;
- successful demo runs, if privacy-respecting event tracking is added; and
- qualified emails, calls, pilots, or consulting requests.

Success is not raw traffic alone. One upstream adoption, credible maintainer
endorsement, or qualified commercial conversation is more valuable than many
untargeted visits.
