// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';

// Project imports:
import '../../../../../foundation/animations/constants.dart';
import '../../../../../foundation/toast.dart';
import '../../../../configs/config/providers.dart';
import '../../../../widgets/context_menu_tile.dart';
import '../../../post/types.dart';
import '../providers/favorites_notifier.dart';
import '../types/types.dart';

class FavoriteContextMenuTile extends ConsumerWidget {
  const FavoriteContextMenuTile({
    required this.post,
    this.feedbackContext,
    super.key,
  });

  final Post post;
  final BuildContext? feedbackContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watchConfigAuth;
    final loginDetails = ref.watch(booruLoginDetailsProvider(config));
    final canFavorite = ref.watch(canFavoriteProvider(config));

    if (!loginDetails.hasLogin() || !canFavorite) {
      return const SizedBox.shrink();
    }

    final notifier = ref.watch(favoritesProvider(config).notifier);
    final params = (config, post.id);
    final isFaved = ref.watch(favoriteStatusProvider(params));
    final isFavorited = isFaved ?? false;
    ref.watch(favoriteStatusLoaderProvider(params));

    return ContextMenuTile(
      title: isFavorited
          ? context.t.post.action.unfavorite
          : context.t.post.action.favorite,
      enabled: isFaved != null,
      onTap: isFaved != null
          ? () {
              unawaited(
                _toggleFavorite(
                  feedbackContext ?? context,
                  notifier,
                  isFavorited: isFavorited,
                  postId: post.id,
                ),
              );
            }
          : null,
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    FavoritesNotifier notifier, {
    required bool isFavorited,
    required int postId,
  }) async {
    final success = isFavorited
        ? await notifier.remove(postId)
        : switch (await notifier.add(postId)) {
            AddFavoriteStatus.success ||
            AddFavoriteStatus.alreadyExists => true,
            _ => false,
          };

    if (!context.mounted) return;

    if (success) {
      showSuccessToast(
        context,
        context.t.favorites.update.success,
        duration: AppDurations.shortToast,
      );
    } else {
      showErrorToast(
        context,
        context.t.favorites.update.failure,
        duration: AppDurations.shortToast,
      );
    }
  }
}
