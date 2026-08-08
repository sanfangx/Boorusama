// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import 'color_utils.dart';

class BooruChipColors {
  factory BooruChipColors.colorScheme(
    ColorScheme colorScheme, {
    bool? harmonizeWithPrimary,
  }) {
    return BooruChipColors._(
      brightness: colorScheme.brightness,
      harmonizer: harmonizeWithPrimary != null && harmonizeWithPrimary
          ? KurumiColorHarmonizer(
              primaryColor: colorScheme.primary,
              harmonizeWithPrimary: harmonizeWithPrimary,
            )
          : null,
    );
  }

  const BooruChipColors._({
    this.brightness,
    this.harmonizer,
  });

  final Brightness? brightness;
  final KurumiColorHarmonizer? harmonizer;

  KurumiChipColors? fromColor(Color? color) {
    if (color == null) return null;

    final legacyColor = LegacyColor(color);

    if (brightness == Brightness.light) {
      final backgroundColor = harmonizer?.harmonize(legacyColor) ?? legacyColor;

      return KurumiChipColors(
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor.computeLuminance() > 0.7
            ? Colors.black
            : Colors.white,
        borderColor: backgroundColor,
      );
    }

    final darkColor = LegacyColor.fromRGBO(
      (legacyColor.red * 0.3).round(),
      (legacyColor.green * 0.3).round(),
      (legacyColor.blue * 0.3).round(),
      1,
    );

    final neutralDarkColor = LegacyColor.fromRGBO(
      (legacyColor.red * 0.5).round(),
      (legacyColor.green * 0.5).round(),
      (legacyColor.blue * 0.5).round(),
      1,
    );

    return KurumiChipColors(
      foregroundColor: harmonizer?.harmonize(legacyColor) ?? legacyColor,
      backgroundColor: harmonizer?.harmonize(darkColor) ?? darkColor,
      borderColor: harmonizer?.harmonize(neutralDarkColor) ?? neutralDarkColor,
    );
  }
}
