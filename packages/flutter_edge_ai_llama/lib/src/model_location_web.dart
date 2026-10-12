import 'package:flutter_edge_ai/engine.dart';
import 'package:flutter_edge_ai/engine_web.dart';
import 'package:llamadart/llamadart.dart';

/// Resolves core's installed URL through the public Web engine SPI.
Future<String> resolveModelLocation(
  ModelSpec spec,
  RuntimeConfig config, {
  WebModelSourceResolver? resolver,
}) async {
  if (config.modelPath.isNotEmpty) return _urlLocation(config.modelPath);
  final resolved = await (resolver ?? WebModelSourceResolver.forActiveModel())
      .resolveActiveInferenceModel();
  return switch (resolved.model) {
    BlobUrlModelSource(:final url) => _urlLocation(url),
    OpfsStreamModelSource() => throw LlamaUnsupportedException(
      'llamadart accepts model URLs, not Edge AI OPFS streams. '
      'Initialize Flutter Edge AI with WebStorageMode.cacheApi or none.',
    ),
  };
}

String _urlLocation(String primary) {
  if (primary.startsWith('opfs://')) {
    throw LlamaUnsupportedException(
      'llamadart accepts model URLs, not Edge AI OPFS streams. '
      'Initialize Flutter Edge AI with WebStorageMode.cacheApi or none.',
    );
  }
  return primary;
}

/// Uses core's public active-spec resolver when core supplies a placeholder.
Future<InferenceModelSpec> resolveInferenceSpec(
  InferenceModelSpec spec,
  RuntimeConfig config, {
  WebModelSourceResolver? resolver,
}) async {
  // An explicit resolved location belongs to the supplied spec. Core's Web
  // shell leaves this empty and asks the provider to resolve the active model.
  if (config.modelPath.isNotEmpty) return spec;
  return (resolver ?? WebModelSourceResolver.forActiveModel())
      .activeInferenceSpec();
}
