// Dart imports:
import 'dart:math';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../themes/colors/providers.dart';

class TagChipsPlaceholder extends ConsumerWidget {
  const TagChipsPlaceholder({
    super.key,
    this.height,
    this.itemCount,
    this.backgroundColor,
  });

  final double? height;
  final int? itemCount;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);

    return Container(
      color: backgroundColor,
      height: height ?? 40,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount ?? 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 8 : 4,
              right: 4,
            ),
            child: KurumiSelectableChip(
              disabledColor: colorScheme.surfaceContainer,
              label: SizedBox(width: Random().nextInt(40).toDouble() + 40),
              padding: const EdgeInsets.all(4),
              labelPadding: const EdgeInsets.all(1),
              visualDensity: VisualDensity.compact,
            ),
          );
        },
      ),
    );
  }
}
