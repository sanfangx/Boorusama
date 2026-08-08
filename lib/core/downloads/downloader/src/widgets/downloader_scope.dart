// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/cupertino.dart';

// Project imports:
import '../../../../download_activity/activity.dart';
import '../../../background/widgets.dart';

class DownloaderScope extends ConsumerWidget {
  const DownloaderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DownloadActivityScope(
      child: BackgroundDownloadRuntime(
        child: child,
      ),
    );
  }
}
