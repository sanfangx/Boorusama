// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../../../../configs/config/providers.dart';
import '../../../../configs/manage/providers.dart';
import '../../../../configs/config/types.dart';
import '../types/constants.dart';
import 'booru_search_bar.dart';

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({
    required this.controller,
    required this.leading,
    super.key,
    this.onSubmitted,
    this.focusNode,
    this.onClear,
    this.onChanged,
    this.trailingSearchButton,
    this.autofocus,
    this.dense,
    this.height,
    this.onTapOutside,
    this.innerSearchButton,
    this.searchBarBuilder,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? leading;
  final void Function(String value)? onSubmitted;
  final VoidCallback? onClear;
  final void Function(String value)? onChanged;
  final Widget? trailingSearchButton;
  final Widget? innerSearchButton;
  final bool? autofocus;
  final bool? dense;
  final double? height;
  final VoidCallback? onTapOutside;
  final Widget Function(BuildContext context, Widget child)? searchBarBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBar = BooruSearchBar(
      dense: dense,
      autofocus: autofocus ?? false,
      onTapOutside: onTapOutside,
      focus: focusNode,
      controller: controller,
      leading: leading,
      trailing: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          return value.text.isNotEmpty
              ? IconButton(
                  splashRadius: 16,
                  icon: const Icon(Symbols.close),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : innerSearchButton ?? const SizedBox.shrink();
        },
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );

    return LayoutBuilder(
      builder: (context, constraints) => AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height ?? kToolbarHeight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: kSearchAppBarWidth,
                ),
                child: switch (searchBarBuilder) {
                  null => searchBar,
                  final builder => builder(context, searchBar),
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: BooruSiteSelectorButton(),
            ),
            if (trailingSearchButton != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: trailingSearchButton,
              ),
          ],
        ),
      ),
    );
  }
}

class BooruSiteSelectorButton extends ConsumerWidget {
  const BooruSiteSelectorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentConfig = ref.watchConfig;
    final orderedConfigsAsync = ref.watch(orderedConfigsProvider);

    return orderedConfigsAsync.when(
      data: (configs) {
        if (configs.length <= 1) return const SizedBox.shrink();

        return Theme(
          data: Theme.of(context).copyWith(
            cardColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: PopupMenuButton<BooruConfig>(
            tooltip: '切换站点',
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.15),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentConfig.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            onSelected: (config) async {
              await ref.read(currentBooruConfigProvider.notifier).update(config);
            },
            itemBuilder: (context) {
              return configs.map((config) {
                final isSelected = config.id == currentConfig.id;
                return PopupMenuItem<BooruConfig>(
                  value: config,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        size: 18,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        config.name,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class SearchAppBarBackButton extends StatelessWidget {
  const SearchAppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 16,
      icon: const Icon(Symbols.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
