// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'favorite_tags_notifier.dart';
import '../types/favorite_tags_sort_type.dart';
import '../types/favorite_tag_filter_type.dart';
import '../types/favorite_tag_group_type.dart';

final selectedFavoriteTagQueryProvider = StateProvider.autoDispose<String>((
  ref,
) {
  return '';
});

final selectedFavoriteTagsSortTypeProvider =
    StateProvider.autoDispose<FavoriteTagsSortType>((ref) {
      return FavoriteTagsSortType.recentlyAdded;
    });

final selectedFavoriteTagLabelProvider =
    AutoDisposeNotifierProvider<SelectedFavoriteTagLabelNotifier, String>(
      SelectedFavoriteTagLabelNotifier.new,
    );

class SelectedFavoriteTagLabelNotifier extends AutoDisposeNotifier<String> {
  @override
  String build() {
    ref.listen<List<String>>(favoriteTagLabelsProvider, (_, labels) {
      if (state.isNotEmpty && !labels.contains(state)) state = '';
    });

    return '';
  }

  void select(String label) => state = label;
}

final selectedFavoriteTagFilterTypeProvider =
    StateProvider.autoDispose<FavoriteTagFilterType>((ref) {
      return FavoriteTagFilterType.all;
    });

final selectedFavoriteTagGroupTypeProvider =
    StateProvider.autoDispose<FavoriteTagGroupType>((ref) {
      return FavoriteTagGroupType.none;
    });
