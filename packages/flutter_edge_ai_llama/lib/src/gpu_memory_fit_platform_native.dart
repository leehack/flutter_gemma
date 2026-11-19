import 'dart:io';

/// Whether the native llama.cpp host supports `ModelParams.gpuMemoryFit`.
///
/// Only Linux and Windows support GPU memory fitting in llamadart; Apple and
/// Android share memory between CPU and GPU and leave loads unchanged.
bool supportsGpuMemoryFit({bool? isLinux, bool? isWindows}) =>
    (isLinux ?? Platform.isLinux) || (isWindows ?? Platform.isWindows);
