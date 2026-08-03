import 'package:flutter/material.dart';

@immutable
class KurumiThemeData {
  const KurumiThemeData({
    required this.materialTheme,
    this.surfaceContainerOverlay = const Color(0x7F000000),
    this.onSurfaceContainerOverlay = Colors.white,
    this.surfaceContainerOverlayDim = const Color(0x7F000000),
    this.onSurfaceContainerOverlayDim = Colors.white70,
  });

  factory KurumiThemeData.fromMaterial(
    ThemeData theme, {
    Color surfaceContainerOverlay = const Color(0x7F000000),
    Color onSurfaceContainerOverlay = Colors.white,
    Color surfaceContainerOverlayDim = const Color(0x7F000000),
    Color onSurfaceContainerOverlayDim = Colors.white70,
  }) => KurumiThemeData(
    materialTheme: theme,
    surfaceContainerOverlay: surfaceContainerOverlay,
    onSurfaceContainerOverlay: onSurfaceContainerOverlay,
    surfaceContainerOverlayDim: surfaceContainerOverlayDim,
    onSurfaceContainerOverlayDim: onSurfaceContainerOverlayDim,
  );

  final ThemeData materialTheme;
  final Color surfaceContainerOverlay;
  final Color onSurfaceContainerOverlay;
  final Color surfaceContainerOverlayDim;
  final Color onSurfaceContainerOverlayDim;

  ThemeData toMaterialTheme() => materialTheme;
}
