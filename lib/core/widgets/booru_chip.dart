// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../themes/colors/providers.dart';

class BooruChip extends ConsumerWidget {
  const BooruChip({
    required this.label,
    super.key,
    this.color,
    this.onPressed,
    this.trailing,
    this.contentPadding,
    this.visualDensity,
    this.borderRadius,
    this.showBackground = true,
    this.showBorder = true,
    this.disabled = false,
    this.chipColors,
  });

  final Color? color;
  final VoidCallback? onPressed;
  final Widget label;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final VisualDensity? visualDensity;
  final BorderRadiusGeometry? borderRadius;
  final bool showBackground;
  final bool showBorder;
  final bool disabled;
  final KurumiChipColors? chipColors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors =
        chipColors ??
        (color != null
            ? ref.watch(booruChipColorsProvider).fromColor(color)
            : null);

    return KurumiChip(
      colors: colors == null
          ? null
          : KurumiChipColors(
              foregroundColor: colors.foregroundColor,
              backgroundColor: colors.backgroundColor,
              borderColor: colors.borderColor,
            ),
      onPressed: onPressed,
      label: label,
      trailing: trailing,
      contentPadding: contentPadding,
      visualDensity: visualDensity,
      borderRadius: borderRadius,
      showBackground: showBackground,
      showBorder: showBorder,
      disabled: disabled,
    );
  }
}
