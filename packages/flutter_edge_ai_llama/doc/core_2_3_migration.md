# Core 2.3 migration preparation

This branch is based on upstream release-train commit
`f4c2069a731b8dff77982749fc0c7d7441fb23f8`, which is still unmerged.
It adds `ModelFileType.gguf` to core and migrates inference to the public engine
libraries. It is preparation evidence, not a published consumer installation.

The GGUF enum value is appended so existing enum indices remain stable. Model
identity persists its name. Binary GGUF declarations must change to `gguf`;
there is no filename-based fallback to another engine. The Web resolver reads
the installed identity and URL through core; OPFS remains explicitly unsupported.

Use Flutter 3.47.1. From the package directory, run:

```sh
python3 tool/verify.py contracts
python3 tool/verify.py package --core-path ../flutter_edge_ai
```

The second command qualifies only the archive against this matching local core.
Before integrating into PR #628, the core train must land and the GGUF addition
must be included in a published release. Set the actual dependency floor, run
`python3 tool/verify.py package` without an override, repeat model/platform
checks, and obtain the final upstream review. Do not merge the unrelated train
commits into the current PR merely to make these APIs available.

## Validation on this branch

Flutter 3.47.1 / Dart 3.13.1: analyzer, 49 VM contracts, 51 Chrome contracts
(three explicit skips), seven demo tests and 22 tooling tests passed. Core
restart/public-surface/formatting suites passed 53 tests. The public import
and Web graph guards passed, including the connector. Real macOS CPU GGUF installation, generation, two-turn recall, cancellation/retry
and fresh-manager restart passed. Browser worker/Wasm inference also passed
through the public Web model resolver. Hosted dependency
resolution and six-platform CI must be repeated after the core release.

The ARM64 iOS simulator smoke passed all three lifecycle cycles with the CI
single-thread CPU profile. Four targeted mutations made regression assertions
fail for GGUF routing, closed state, Web identity and OPFS rejection; all were
restored. Local-core archive validation passed with the expected Unreleased
changelog warning and explicit dependency-override hint. This does not qualify
published core dependency resolution.
