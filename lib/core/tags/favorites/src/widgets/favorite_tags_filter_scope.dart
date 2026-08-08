// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../search/selected_tags/types.dart';
import '../providers/favorite_tags_notifier.dart';
import '../types/favorite_tag.dart';
import '../types/favorite_tag_filter_type.dart';
import '../types/favorite_tags_sort_type.dart';

class FavoriteTagsFilterScope extends ConsumerStatefulWidget {
  const FavoriteTagsFilterScope({
    required this.builder,
    super.key,
    this.initialValue,
    this.filterQuery,
    this.filterType,
    this.sortType,
  });

  final String? initialValue;
  final String? filterQuery;
  final FavoriteTagFilterType? filterType;
  final FavoriteTagsSortType? sortType;

  final Widget Function(
    BuildContext context,
    List<FavoriteTag> tags,
    List<String> labels,
    String selectedLabel,
  )
  builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavoriteTagsFilterScopeState();
}

class _FavoriteTagsFilterScopeState
    extends ConsumerState<FavoriteTagsFilterScope> {
  late var selectedLabel = widget.initialValue ?? '';
  late var filterQuery = widget.filterQuery ?? '';
  late var filterType = widget.filterType ?? FavoriteTagFilterType.all;
  late var sortType = widget.sortType ?? FavoriteTagsSortType.recentlyAdded;

  @override
  void didUpdateWidget(covariant FavoriteTagsFilterScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      selectedLabel = widget.initialValue ?? '';
    }

    if (oldWidget.filterQuery != widget.filterQuery) {
      filterQuery = widget.filterQuery ?? '';
    }

    if (oldWidget.filterType != widget.filterType) {
      filterType = widget.filterType ?? FavoriteTagFilterType.all;
    }

    if (oldWidget.sortType != widget.sortType) {
      sortType = widget.sortType ?? FavoriteTagsSortType.recentlyAdded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tags = ref.watch(favoriteTagsProvider);
    final labels = ref.watch(favoriteTagLabelsProvider);
    final filteredTags = tags.where((e) {
      if (selectedLabel.isEmpty) return true;

      return e.labels?.contains(selectedLabel) ?? false;
    }).toList();

    final filteredTagsWithType = filteredTags.where((e) {
      return switch (filterType) {
        FavoriteTagFilterType.all => true,
        FavoriteTagFilterType.tags => e.queryType != QueryType.simple,
        FavoriteTagFilterType.rawQueries => e.queryType == QueryType.simple,
      };
    }).toList();

    final normalizedQuery = filterQuery.toLowerCase();
    final filteredTagsWithQuery = filteredTagsWithType.where((e) {
      if (filterQuery.isEmpty) return true;

      return e.name.toLowerCase().contains(normalizedQuery) ||
          (e.labels?.any(
                (label) => label.toLowerCase().contains(normalizedQuery),
              ) ??
              false);
    }).toList();

    final sortedTags = filteredTagsWithQuery.toList()
      ..sort(
        (a, b) => switch (sortType) {
          FavoriteTagsSortType.recentlyAdded => b.createdAt.compareTo(
            a.createdAt,
          ),
          FavoriteTagsSortType.recentlyUpdated => switch ((
            a.updatedAt,
            b.updatedAt,
          )) {
            (final DateTime ua, final DateTime ub) => ub.compareTo(ua),
            _ => 0,
          },
          FavoriteTagsSortType.nameAZ => a.name.compareTo(b.name),
          FavoriteTagsSortType.nameZA => b.name.compareTo(a.name),
        },
      );

    return widget.builder(
      context,
      sortedTags,
      labels,
      tags.isEmpty ? '' : selectedLabel,
    );
  }
}
