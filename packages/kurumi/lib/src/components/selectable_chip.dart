import 'package:flutter/material.dart';

/// The app's shared selectable/tag chip surface.
///
/// This keeps the existing compact Material chip behavior in one Kurumi
/// primitive while allowing feature code to supply its own label, selection
/// state, and domain colors.
class KurumiSelectableChip extends StatelessWidget {
  const KurumiSelectableChip({
    required this.label,
    super.key,
    this.selected = false,
    this.onSelected,
    this.onPressed,
    this.onDeleted,
    this.deleteIcon,
    this.deleteButtonTooltipMessage,
    this.avatar,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.checkmarkColor,
    this.side,
    this.shape,
    this.padding,
    this.labelPadding,
    this.visualDensity,
    this.labelStyle,
    this.showCheckmark = true,
    this.tapEnabled = true,
    this.materialTapTargetSize,
  });

  final Widget label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final Widget? deleteIcon;
  final String? deleteButtonTooltipMessage;
  final Widget? avatar;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? checkmarkColor;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final VisualDensity? visualDensity;
  final TextStyle? labelStyle;
  final bool showCheckmark;
  final bool tapEnabled;
  final MaterialTapTargetSize? materialTapTargetSize;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      child: RawChip(
        label: label,
        selected: selected,
        onSelected: onSelected,
        onPressed: onPressed,
        onDeleted: onDeleted,
        deleteIcon: deleteIcon,
        deleteButtonTooltipMessage: deleteButtonTooltipMessage,
        avatar: avatar,
        backgroundColor: backgroundColor,
        selectedColor: selectedColor,
        disabledColor: disabledColor,
        checkmarkColor: checkmarkColor,
        side: side,
        shape: shape,
        padding: padding,
        labelPadding: labelPadding,
        visualDensity: visualDensity,
        labelStyle: labelStyle,
        showCheckmark: showCheckmark,
        tapEnabled: tapEnabled,
        materialTapTargetSize: materialTapTargetSize,
      ),
    );
  }
}
