// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../../search/selected_tags/types.dart';
import '../types/favorite_tag.dart';
import 'providers.dart';

final favoriteTagsProvider =
    NotifierProvider<FavoriteTagsNotifier, List<FavoriteTag>>(
      FavoriteTagsNotifier.new,
      dependencies: [
        favoriteTagRepoProvider,
      ],
    );

final favoriteTagLabelsProvider = Provider<List<String>>((ref) {
  final tags = ref.watch(favoriteTagsProvider);
  final tagLabels = tags.expand((e) => e.labels ?? <String>[]).toSet();

  final labels = tagLabels.toList()..sort();

  return labels;
});

class FavoriteTagsNotifier extends Notifier<List<FavoriteTag>> {
  @override
  List<FavoriteTag> build() {
    load();
    return [];
  }

  Future<FavoriteTagRepository> get repo =>
      ref.read(favoriteTagRepoProvider.future);

  Future<void> load() async {
    final tags = await (await repo).getAll();

    state = tags..sort((a, b) => a.name.compareTo(b.name));
  }

  Future<bool> add(
    String tag, {
    List<String>? labels,
    void Function(String tag)? onDuplicate,
    bool? isRaw,
  }) async {
    if (tag.isEmpty) return false;

    // If a tag length is larger than 255 characters, we will not add it.
    // This is a limitation of Hive.
    if (tag.length > 255) return false;

    // check for existing tag
    final existing = state.firstWhereOrNull((e) => e.name == tag);

    if (existing != null) {
      onDuplicate?.call(existing.name);
      return false;
    }

    final repo = await this.repo;
    await repo.create(
      name: tag,
      labels: labels != null && labels.isNotEmpty
          ? labels
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toSet()
                .toList()
          : null,
      queryType: (isRaw ?? false) ? QueryType.simple : null,
    );

    await _refresh(repo);
    return true;
  }

  Future<bool> update(String tag, FavoriteTag newTag) async {
    if (tag.isEmpty || newTag.name.isEmpty || newTag.name.length > 255) {
      return false;
    }

    final duplicate = state.firstWhereOrNull(
      (e) => e.name == newTag.name && e.name != tag,
    );
    if (duplicate != null) return false;

    final repo = await this.repo;
    final targetTag = await repo.getFirst(tag);

    if (targetTag != null) {
      await repo.updateFirst(
        tag,
        newTag.ensureValid(),
      );

      await _refresh(repo);
      return true;
    }

    return false;
  }

  Future<FavoriteTag?> remove(String name) async {
    if (name.isEmpty) return null;

    final repo = await this.repo;
    final tag = await repo.getFirst(name);

    if (tag != null) {
      final deleted = await repo.deleteFirst(tag.name);

      if (deleted != null) {
        await _refresh(repo);
        return deleted;
      }
    }

    return null;
  }

  Future<bool> restore(FavoriteTag tag) async {
    final repo = await this.repo;
    final restored = await repo.restore(tag);
    await _refresh(repo);
    return restored != null;
  }

  Future<void> renameLabel(String oldLabel, String newLabel) async {
    final normalized = newLabel.trim();
    if (oldLabel.isEmpty || normalized.isEmpty || oldLabel == normalized) {
      return;
    }

    await _replaceLabel(oldLabel, normalized);
  }

  Future<void> mergeLabel(String sourceLabel, String targetLabel) async {
    final normalized = targetLabel.trim();
    if (sourceLabel.isEmpty ||
        normalized.isEmpty ||
        sourceLabel == normalized) {
      return;
    }

    await _replaceLabel(sourceLabel, normalized);
  }

  Future<void> removeLabelFromAll(String label) async {
    if (label.isEmpty) return;

    final repo = await this.repo;
    final affected = state.where((tag) => tag.labels?.contains(label) ?? false);

    for (final tag in affected) {
      final labels = [...?tag.labels]..removeWhere((e) => e == label);
      await repo.updateFirst(
        tag.name,
        tag.copyWith(labels: () => labels.isEmpty ? null : labels),
      );
    }

    await _refresh(repo);
  }

  Future<void> _replaceLabel(String oldLabel, String newLabel) async {
    final repo = await this.repo;
    final affected = state.where(
      (tag) => tag.labels?.contains(oldLabel) ?? false,
    );

    for (final tag in affected) {
      final labels = {
        for (final label in tag.labels ?? const <String>[])
          if (label == oldLabel) newLabel else label,
      }.toList();

      await repo.updateFirst(
        tag.name,
        tag.copyWith(labels: () => labels),
      );
    }

    await _refresh(repo);
  }

  Future<void> import(String tagString) async {
    if (tagString.isEmpty) return;

    final repo = await this.repo;
    final tags = tagString.split(' ');
    for (final t in tags) {
      await repo.create(name: t);
    }

    await _refresh(repo);
  }

  Future<void> export({
    required void Function(String tagString) onDone,
  }) async {
    final repo = await this.repo;
    final tags = await repo.getAll();
    final tagString = tags.map((e) => e.name).join(' ');

    onDone(tagString);
  }

  Future<void> _refresh(FavoriteTagRepository repo) async {
    final tags = await repo.getAll();
    state = tags..sort((a, b) => a.name.compareTo(b.name));
  }
}
