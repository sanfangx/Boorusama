// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../search/histories/providers.dart';
import '../../../search/histories/types.dart';
import '../../../search/histories/widgets.dart';
import '../../../search/search/routes.dart';
import '../../../search/selected_tags/types.dart';
import '../../../widgets/widgets.dart';

class BulkDownloadTagList extends ConsumerWidget {
  const BulkDownloadTagList({
    required this.tags,
    required this.onSubmit,
    required this.onRemove,
    required this.onHistoryTap,
    super.key,
  });

  final void Function(String tag) onSubmit;
  final void Function(String tag) onRemove;
  final void Function(SearchHistory history) onHistoryTap;
  final SearchTagSet tags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TagChipInput(
      values: tags.list,
      onRemove: onRemove,
      onAdd: () {
        goToQuickSearchPage(
          context,
          ref: ref,
          emptyBuilder: (controller) => ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, value, _) => value.text.isEmpty
                ? ref
                      .watch(searchHistoryProvider)
                      .maybeWhen(
                        data: (data) => SearchHistorySection(
                          maxHistory: 20,
                          showTime: true,
                          histories: data.histories,
                          onHistoryTap: (history) {
                            Navigator.of(context).pop();
                            onHistoryTap(history);
                          },
                        ),
                        orElse: () => const SizedBox.shrink(),
                      )
                : const SizedBox.shrink(),
          ),
          onSubmitted: (context, text, _) {
            Navigator.of(context).pop();
            onSubmit(text);
          },
          onSelected: (tag, _) {
            onSubmit(tag);
          },
        );
      },
    );
  }
}
