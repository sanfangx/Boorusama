// Package imports:
import 'package:cache_manager/cache_manager.dart';
import 'package:coreutils/coreutils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/material.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import '../../../../foundation/filesystem.dart';
import '../../../configs/config/types.dart';
import '../../../downloads/filename/types.dart';
import '../../details/providers.dart';
import '../../post/providers.dart';
import '../../post/types.dart';
import '../../sources/types.dart';
import 'download_and_share.dart';
import 'share.dart';

final shareProvider = Provider.autoDispose((ref) => ShareService(ref));

class ShareService {
  ShareService(this.ref);

  final Ref ref;

  Future<void> sharePost(
    Post post,
    BooruConfigAuth config, {
    required BuildContext context,
    required BooruConfigViewer configViewer,
    required BooruConfigDownload download,
    required DownloadFilenameGenerator? filenameBuilder,
    required ImageCacheManager imageCacheManager,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;

    if (post.isVideo) {
      await showDialog(
        context: context,
        builder: (context) => DownloadAndShareDialog(
          post: post,
          auth: config,
          download: download,
          filenameBuilder: filenameBuilder,
        ),
      );
      return;
    }

    final mediaUrlResolver = ref.read(mediaUrlResolverProvider(config));
    final imageUrl = mediaUrlResolver.resolveMediaUrl(post, configViewer);
    final imageExt = post.format;

    if (imageUrl != null) {
      final ext = urlExtension(imageUrl);
      final effectiveExt = ext.isNotEmpty ? ext : imageExt;

      final cacheKey = imageCacheManager.generateCacheKey(imageUrl);
      final filePath = await imageCacheManager.getCachedFilePath(cacheKey);

      if (filePath != null && effectiveExt != null) {
        final newPath = filePath + effectiveExt;
        final fs = ref.read(appFileSystemProvider);
        final file = fileCopySync(fs, filePath, newPath);

        if (file != null) {
          await SharePlus.instance.share(
            ShareParams(
              files: [file],
              subject: file.name,
              sharePositionOrigin: rect,
            ),
          );
          return;
        }
      }
    }

    // Fallback: share booru link or source link if image is not cached yet
    final postLinkGenerator = ref.read(postLinkGeneratorProvider(config));
    final booruLink = postLinkGenerator.getLink(post);

    if (booruLink.isNotEmpty) {
      if (Uri.tryParse(booruLink) case final Uri uri) {
        await SharePlus.instance.share(
          ShareParams(
            uri: uri,
            subject: booruLink,
            sharePositionOrigin: rect,
          ),
        );
        return;
      }
    }

    if (post.source case final WebSource s) {
      await SharePlus.instance.share(
        ShareParams(
          uri: s.uri,
          sharePositionOrigin: rect,
        ),
      );
    }
  }
}
