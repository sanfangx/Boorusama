// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../../foundation/clipboard.dart';
import '../../../../blacklists/providers.dart';
import '../../../../posts/details/src/routes/details_route_context.dart';
import '../../../../search/search/routes.dart';
import '../../../../search/selected_tags/types.dart';
import '../../../favorites/providers.dart';

class GeneralTagContextMenu extends ConsumerWidget
    with TagContextMenuItemsMixin {
  const GeneralTagContextMenu({
    required this.tag,
    required this.child,
    super.key,
    this.itemBindings = const {},
  });

  final String tag;
  final Widget child;
  final Map<String, void Function()> itemBindings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalNotifier = ref.watch(globalBlacklistedTagsProvider.notifier);

    return KurumiContextMenu(
      menuItemsBuilder: (_) => [
        copyButton(context, tag),
        searchButton(ref, tag),
        addToSearchButton(context, ref, tag),
        excludeFromSearchButton(context, ref, tag),
        KurumiContextMenuTile(
          title: context.t.post.detail.add_to_favorites,
          onTap: () {
            ref.read(favoriteTagsProvider.notifier).add(tag);
          },
        ),
        KurumiContextMenuTile(
          title: context.t.tags.actions.add_to_blacklist_global,
          onTap: () {
            globalNotifier.addTagWithToast(context, tag);
          },
        ),
        for (final entry in itemBindings.entries)
          KurumiContextMenuTile(
            title: entry.key,
            onTap: entry.value,
          ),
      ],
      child: child,
    );
  }
}

mixin TagContextMenuItemsMixin {
  Widget copyButton(BuildContext context, String tag) => KurumiContextMenuTile(
    title: context.t.tags.actions.copy_single,
    onTap: () {
      AppClipboard.copyAndToast(
        context,
        tag,
        message: context.t.generic.copied,
      );
    },
  );

  Widget searchButton(WidgetRef ref, String tag) => KurumiContextMenuTile(
    title: ref.context.t.tags.actions.search_single,
    onTap: () {
      goToSearchPage(ref, tag: tag);
    },
  );

  SearchTagSet _getCurrentTags(BuildContext context, WidgetRef ref) {
    try {
      final state = GoRouterState.of(ref.context);
      if (state.extra is DetailsRouteContext) {
        final detailsContext = state.extra as DetailsRouteContext;
        if (detailsContext.searchTags != null) {
          return detailsContext.searchTags!.clone();
        }
      }
    } catch (_) {}

    final lastParams = ref.read(lastSearchParamsProvider);
    final currentTags = lastParams?.tags?.clone() ?? SearchTagSet();
    if (lastParams?.query != null && lastParams!.query!.isNotEmpty) {
      currentTags.merge(SearchTagSet.fromString(lastParams.query));
    }
    return currentTags;
  }

  Widget addToSearchButton(BuildContext context, WidgetRef ref, String tag) =>
      KurumiContextMenuTile(
        title: context.t.tags.actions.add_to_search,
        onTap: () {
          final currentTags = _getCurrentTags(context, ref);
          currentTags.addTag(TagSearchItem.raw(tag: tag));
          goToSearchPage(ref, tags: currentTags);
        },
      );

  Widget excludeFromSearchButton(
    BuildContext context,
    WidgetRef ref,
    String tag,
  ) => KurumiContextMenuTile(
    title: context.t.tags.actions.exclude_from_search,
    onTap: () {
      final currentTags = _getCurrentTags(context, ref);
      currentTags.addTag(TagSearchItem.fromString('-$tag'));
      goToSearchPage(ref, tags: currentTags);
    },
  );
}
