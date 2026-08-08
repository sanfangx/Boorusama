// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'error.dart';

class DownloadTaskInfo extends Equatable {
  const DownloadTaskInfo({
    required this.path,
    required this.id,
  });

  final String path;
  final String id;

  @override
  List<Object?> get props => [path, id];
}

sealed class DownloadResult {
  const DownloadResult();
}

enum DownloadCompletionSource { network, cache, alreadyPresent }

final class DownloadEnqueued extends DownloadResult {
  const DownloadEnqueued(this.info);

  final DownloadTaskInfo info;
}

final class DownloadCompleted extends DownloadResult {
  const DownloadCompleted(
    this.info, {
    required this.source,
  });

  final DownloadTaskInfo info;
  final DownloadCompletionSource source;
}

final class DownloadSkipped extends DownloadResult {
  const DownloadSkipped(this.info);

  final DownloadTaskInfo info;
}

final class DownloadFailure extends DownloadResult {
  const DownloadFailure(this.error);

  final DownloadError error;
}
