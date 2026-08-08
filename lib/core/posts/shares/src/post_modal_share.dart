// Package imports:
import 'package:cache_manager/cache_manager.dart';
import 'package:coreutils/coreutils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import '../../../../foundation/filesystem.dart';
import '../../../config_widgets/website_logo.dart';
import '../../../configs/config/types.dart';
import '../../../downloads/filename/types.dart';
import '../../details/providers.dart';
import '../../post/providers.dart';
import '../../post/types.dart';
import '../../sources/types.dart';
import 'download_and_share.dart';
import 'share.dart';

final _cachedImageFileProvider = FutureProvider.autoDispose
    .family<XFile?, ModalShareImageData>(
      (ref, data) async {
        final imageUrl = data.imageUrl;
        final imageExt = data.imageExt;

        if (imageUrl == null) return null;

        final ext = urlExtension(imageUrl);
        final effectiveExt = ext.isNotEmpty ? ext : imageExt;

        final cacheManager = data.imageCacheManager;
        final cacheKey = cacheManager.generateCacheKey(imageUrl);
        final filePath = await cacheManager.getCachedFilePath(cacheKey);

        if (filePath == null || effectiveExt == null) return null;

        // attach the extension to the file
        final newPath = filePath + effectiveExt;
        final fs = ref.watch(appFileSystemProvider);
        final xFile = fileCopySync(fs, filePath, newPath);

        return xFile;
      },
    );

typedef ModalShareImageData = ({
  String? imageUrl,
  String? imageExt,
  ImageCacheManager imageCacheManager,
});

class PostModalShare extends ConsumerWidget {
  const PostModalShare({
    required this.post,
    required this.auth,
    required this.viewer,
    required this.download,
    required this.filenameBuilder,
    required this.imageCacheManager,
    super.key,
  });

  final Post post;
  final BooruConfigAuth auth;
  final BooruConfigViewer viewer;
  final BooruConfigDownload download;
  final DownloadFilenameGenerator? filenameBuilder;
  final ImageCacheManager imageCacheManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaUrlResolver = ref.watch(
      mediaUrlResolverProvider(auth),
    );
    final imageData = (
      imageUrl: mediaUrlResolver.resolveMediaUrl(post, viewer),
      imageExt: post.format,
      imageCacheManager: imageCacheManager,
    );

    final postLinkGenerator = ref.watch(postLinkGeneratorProvider(auth));
    final booruLink = postLinkGenerator.getLink(post);
    final sourceLink = post.source;
    final isVideo = post.isVideo;

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            switch (sourceLink) {
              final WebSource s => ListTile(
                title: Text(context.t.post.detail.share.source),
                subtitle: Text(s.uri.toString()),
                leading: ConfigAwareWebsiteLogo(url: s.url),
                onTap: () {
                  Navigator.of(context).pop();
                  SharePlus.instance.share(ShareParams(uri: s.uri));
                },
              ),
              _ => const SizedBox.shrink(),
            },
            if (booruLink.isNotEmpty)
              if (Uri.tryParse(booruLink) case final Uri uri)
                ListTile(
                  title: Text(context.t.post.detail.share.booru),
                  subtitle: Text(booruLink),
                  leading: ConfigAwareWebsiteLogo(url: booruLink),
                  onTap: () {
                    Navigator.of(context).pop();
                    SharePlus.instance.share(
                      ShareParams(
                        uri: uri,
                        subject: booruLink,
                      ),
                    );
                  },
                ),
            if (isVideo)
              ListTile(
                title: Text(context.t.post.detail.share.file),
                leading: const Icon(
                  Symbols.play_circle,
                  fill: 1,
                ),
                onTap: () {
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (context) => DownloadAndShareDialog(
                      post: post,
                      auth: auth,
                      download: download,
                      filenameBuilder: filenameBuilder,
                    ),
                  );
                },
              )
            else ...[
              ref
                  .watch(_cachedImageFileProvider(imageData))
                  .when(
                    data: (file) {
                      return file != null
                          ? ListTile(
                              title: Text(context.t.post.detail.share.image),
                              leading: const Icon(
                                Symbols.image,
                                fill: 1,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();

                                SharePlus.instance.share(
                                  ShareParams(
                                    files: [file],
                                    subject: file.name,
                                  ),
                                );
                              },
                            )
                          : const SizedBox.shrink();
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, stack) => const SizedBox.shrink(),
                  ),
              ListTile(
                title: Text(context.t.post.detail.share.file),
                leading: const Icon(
                  Symbols.download,
                  fill: 1,
                ),
                onTap: () {
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (context) => DownloadAndShareDialog(
                      post: post,
                      auth: auth,
                      download: download,
                      filenameBuilder: filenameBuilder,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
