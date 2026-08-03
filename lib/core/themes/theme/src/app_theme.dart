// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dynamic_color/dynamic_color.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../../foundation/display.dart';
import '../../colors/types.dart';
import 'theme_mode.dart';

const staticLightScheme = KurumiColorSchemes.light;
const staticDarkScheme = KurumiColorSchemes.dark;
const staticBlackScheme = KurumiColorSchemes.amoledDark;
const staticLightExtendedScheme = KurumiColorSchemes.lightExtended;
const staticDarkExtendedScheme = KurumiColorSchemes.darkExtended;
const staticBlackExtendedScheme = KurumiColorSchemes.amoledDarkExtended;

class AppTheme {
  AppTheme._();

  static ColorScheme generateScheme(
    AppThemeMode mode, {
    required bool systemDarkMode,
    ColorScheme? dynamicDarkScheme,
    ColorScheme? dynamicLightScheme,
  }) => switch ((dynamicDarkScheme, dynamicLightScheme)) {
    (final ColorScheme dark, final ColorScheme light) => switch (mode) {
      AppThemeMode.light => light.harmonized(),
      AppThemeMode.dark => dark.harmonized(),
      AppThemeMode.amoledDark => staticBlackScheme.copyWith(
        primary: dark.primary,
        onPrimary: dark.onPrimary,
      ),
      AppThemeMode.system =>
        systemDarkMode ? dark.harmonized() : light.harmonized(),
    },
    _ => switch (mode) {
      AppThemeMode.light => staticLightScheme,
      AppThemeMode.dark => staticDarkScheme,
      AppThemeMode.amoledDark => staticBlackScheme,
      AppThemeMode.system =>
        systemDarkMode ? staticDarkScheme : staticLightScheme,
    },
  };

  static ThemeData themeFrom(
    AppThemeMode? mode, {
    required ColorScheme colorScheme,
    required bool systemDarkMode,
  }) => switch (mode) {
    AppThemeMode.light => lightTheme(
      colorScheme: colorScheme,
      extendedColorScheme: staticLightExtendedScheme,
    ),
    AppThemeMode.dark => darkTheme(
      colorScheme: colorScheme,
      extendedColorScheme: staticDarkExtendedScheme,
    ),
    AppThemeMode.amoledDark =>
      darkTheme(
        colorScheme: colorScheme,
        extendedColorScheme: staticBlackExtendedScheme,
      ).copyWith(
        dividerTheme: const DividerThemeData(
          endIndent: 0,
          indent: 0,
        ),
      ),
    AppThemeMode.system =>
      systemDarkMode
          ? darkTheme(
              colorScheme: colorScheme,
              extendedColorScheme: staticDarkExtendedScheme,
            )
          : lightTheme(
              colorScheme: colorScheme,
              extendedColorScheme: staticLightExtendedScheme,
            ),
    null => switch (colorScheme.brightness) {
      Brightness.light => lightTheme(
        colorScheme: colorScheme,
        extendedColorScheme: staticLightExtendedScheme,
      ),
      Brightness.dark => darkTheme(
        colorScheme: colorScheme,
        extendedColorScheme: staticDarkExtendedScheme,
      ),
    },
  };

  static ThemeData lightTheme({
    required ColorScheme colorScheme,
    required KurumiExtendedColorScheme extendedColorScheme,
  }) =>
      KurumiMaterialTheme.lightTheme(
        colorScheme: colorScheme,
        extendedColorScheme: extendedColorScheme,
        isDesktop: kPreferredLayout.isDesktop,
      ).copyWith(
        extensions: [
          const BoorusamaColors(
            upvoteColor: Colors.redAccent,
            downvoteColor: Colors.blueAccent,
          ),
          extendedColorScheme,
        ],
      );

  static ThemeData darkTheme({
    required ColorScheme colorScheme,
    required KurumiExtendedColorScheme extendedColorScheme,
  }) =>
      KurumiMaterialTheme.darkTheme(
        colorScheme: colorScheme,
        extendedColorScheme: extendedColorScheme,
        isDesktop: kPreferredLayout.isDesktop,
      ).copyWith(
        extensions: [
          const BoorusamaColors(
            upvoteColor: Colors.redAccent,
            downvoteColor: Colors.blueAccent,
          ),
          extendedColorScheme,
        ],
      );

  static ThemeData defaultTheme({
    required ColorScheme colorScheme,
  }) => KurumiMaterialTheme.defaultTheme(
    colorScheme: colorScheme,
    isDesktop: kPreferredLayout.isDesktop,
  );
}
