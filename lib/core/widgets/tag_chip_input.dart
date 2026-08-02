// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../../foundation/platform.dart';

class TagChipInput extends StatelessWidget {
  const TagChipInput({
    required this.values,
    required this.onAdd,
    required this.onRemove,
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.displayValue,
  });

  final Iterable<String> values;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  final EdgeInsetsGeometry margin;
  final String Function(String value)? displayValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: margin,
      child: Wrap(
        runAlignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: isMobilePlatform() ? -4 : 8,
        children: [
          for (final value in values)
            Chip(
              backgroundColor: colorScheme.surfaceContainerHighest,
              label: Text(
                displayValue?.call(value) ?? value.replaceAll('_', ' '),
              ),
              deleteIcon: Icon(
                Symbols.close,
                size: 16,
                color: colorScheme.error,
              ),
              onDeleted: () => onRemove(value),
            ),
          IconButton(
            iconSize: 28,
            splashRadius: 20,
            onPressed: onAdd,
            icon: const Icon(Symbols.add),
          ),
        ],
      ),
    );
  }
}
