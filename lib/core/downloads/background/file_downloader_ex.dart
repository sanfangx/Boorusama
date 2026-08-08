// Package imports:
import 'package:background_downloader/background_downloader.dart';

// Project imports:
import '../../../foundation/filesystem.dart';
import '../downloader/types.dart';

extension FileDownloaderX on FileDownloader {
  Future<DownloadResult> enqueueIfNeeded(
    DownloadTask task, {
    bool? skipIfExists,
    required AppFileSystem fs,
  }) async {
    final file = await task.filePath();

    if (skipIfExists ?? false) {
      if (fs.fileExistsSync(file)) {
        return DownloadSkipped(
          DownloadTaskInfo(
            path: file,
            id: task.taskId,
          ),
        );
      }
    }

    await enqueue(task);

    return DownloadEnqueued(
      DownloadTaskInfo(
        path: file,
        id: task.taskId,
      ),
    );
  }

  Future<void> retryTask(
    Task task, {
    Map<String, String>? headers,
  }) async {
    if (headers == null || headers.isEmpty) {
      await enqueue(task);
      return;
    }

    final mergedHeaders = Map<String, String>.from(task.headers);
    for (final header in headers.entries) {
      final existingKeys = mergedHeaders.keys
          .where((key) => key.toLowerCase() == header.key.toLowerCase())
          .toList();
      existingKeys.forEach(mergedHeaders.remove);
      mergedHeaders[header.key] = header.value;
    }

    await enqueue(task.copyWith(headers: mergedHeaders));
  }
}
