// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

import 'components/adaptive_sheet.dart' as adaptive_sheet;
import 'components/bottom_sheet.dart' as bottom_sheet;
import 'components/hero.dart' as hero;
import 'components/route_transition.dart' as route_transition;
import 'components/segmented_button.dart' as segmented_button;
import 'components/toast.dart' as toast;
import 'foundation/platform.dart' as platform;
import 'foundation/preferred_layout.dart' as preferred_layout;

/// The callable and value-based API for the Kurumi design language.
///
/// Visual component and theme types remain top-level so they work naturally
/// with Dart's type system. Runtime helpers and shared values live here to
/// keep the public API discoverable under one namespace.
abstract final class Kurumi {
  const Kurumi._();

  static bool isMobilePlatform() => platform.kurumiIsMobilePlatform();

  static bool isDesktopPlatform() => platform.kurumiIsDesktopPlatform();

  static preferred_layout.KurumiPreferredLayout get preferredLayout =>
      preferred_layout.kurumiPreferredLayout;

  static const bool enableHeroTransition = hero.kKurumiEnableHeroTransition;

  static Future<T?> showModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    RouteSettings? routeSettings,
    bool enableDrag = true,
    bool showDragHandle = true,
    bool resizeToAvoidBottomInset = false,
    bool useSafeArea = false,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) => bottom_sheet.showKurumiModalBottomSheet<T>(
    context: context,
    builder: builder,
    routeSettings: routeSettings,
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    useSafeArea: useSafeArea,
    backgroundColor: backgroundColor,
    shape: shape,
  );

  static void showSuccessToast(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) => toast.kurumiShowSuccessToast(
    context,
    message,
    duration: duration,
    backgroundColor: backgroundColor,
    textStyle: textStyle,
  );

  static void showErrorToast(
    BuildContext context,
    String message, {
    Duration? duration,
  }) => toast.kurumiShowErrorToast(
    context,
    message,
    duration: duration,
  );

  static void showSimpleSnackBar({
    required BuildContext context,
    required Widget content,
    Duration? duration,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) => toast.kurumiShowSimpleSnackBar(
    context: context,
    content: content,
    duration: duration,
    behavior: behavior,
    action: action,
  );

  static Future<T?> showAdaptiveSheet<T>(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    bool expand = false,
    double? width,
    Color? backgroundColor,
    RouteSettings? settings,
  }) => adaptive_sheet.kurumiShowAdaptiveSheet<T>(
    context,
    builder: builder,
    expand: expand,
    width: width,
    backgroundColor: backgroundColor,
    settings: settings,
  );

  static Future<T?> showAdaptiveBottomSheet<T>(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    bool expand = false,
    double? height,
    Color? backgroundColor,
    RouteSettings? settings,
  }) => adaptive_sheet.kurumiShowAdaptiveBottomSheet<T>(
    context,
    builder: builder,
    expand: expand,
    height: height,
    backgroundColor: backgroundColor,
    settings: settings,
  );

  static Future<T?> showAppModalBarBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    ShapeBorder? shape,
    Color barrierColor = Colors.black87,
    bool bounce = true,
    bool expand = false,
    Curve? animationCurve,
    bool useRootNavigator = false,
    bool isDismissible = true,
    Duration? duration,
    RouteSettings? settings,
  }) => adaptive_sheet.kurumiShowAppModalBarBottomSheet<T>(
    context: context,
    settings: settings,
    barrierColor: barrierColor,
    duration: duration,
    backgroundColor: backgroundColor,
    shape: shape,
    bounce: bounce,
    expand: expand,
    animationCurve: animationCurve,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    builder: builder,
  );

  static Future<T?> showSideSheetFromLeft<T>({
    required Widget body,
    required BuildContext context,
    double? width,
    String barrierLabel = 'Side Sheet',
    bool barrierDismissible = true,
    Color barrierColor = const Color(0xFF66000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteSettings? settings,
  }) => adaptive_sheet.kurumiShowSideSheetFromLeft<T>(
    body: body,
    context: context,
    width: width,
    barrierLabel: barrierLabel,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    settings: settings,
  );

  static Future<T?> showSideSheetFromRight<T>({
    required Widget body,
    required BuildContext context,
    double? width,
    String barrierLabel = 'Side Sheet',
    bool barrierDismissible = true,
    Color barrierColor = const Color(0xFF66000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteSettings? settings,
  }) => adaptive_sheet.kurumiShowSideSheetFromRight<T>(
    body: body,
    context: context,
    width: width,
    barrierLabel: barrierLabel,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    settings: settings,
  );

  static RouteTransitionsBuilder parallaxSlideInTransitionBuilder(
    Widget enterWidget,
    Widget oldWidget,
  ) => route_transition.kurumiParallaxSlideInTransitionBuilder(
    enterWidget,
    oldWidget,
  );

  static RouteTransitionsBuilder leftToRightTransitionBuilder() =>
      route_transition.kurumiLeftToRightTransitionBuilder();

  static RouteTransitionsBuilder fadeTransitionBuilder() =>
      route_transition.kurumiFadeTransitionBuilder();

  static double computeSegmentOffset<T>({
    required List<double> sizes,
    required List<T?> items,
    T? current,
  }) => segmented_button.kurumiComputeSegmentOffset<T>(
    sizes: sizes,
    items: items,
    current: current,
  );
}
