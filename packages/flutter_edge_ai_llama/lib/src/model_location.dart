import 'package:flutter_edge_ai/engine.dart';

/// Native core has already resolved the primary model to a local path.
Future<String> resolveModelLocation(
  ModelSpec spec,
  RuntimeConfig config,
) async => config.modelPath;

/// Native core supplies the real inference identity to its provider.
Future<InferenceModelSpec> resolveInferenceSpec(
  InferenceModelSpec spec,
  RuntimeConfig config,
) async => spec;
