import 'package:flutter/widgets.dart';

import '../accessibility/behavior.dart';
import 'semantic_tokens.dart';
import 'theme_data.dart';

class KurumiTheme extends InheritedTheme {
  const KurumiTheme({
    required this.data,
    required super.child,
    this.behavior = const KurumiBehaviorData(),
    super.key,
  });

  final KurumiThemeData data;
  final KurumiBehaviorData behavior;

  static KurumiThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<KurumiTheme>();
    assert(theme != null, 'No KurumiTheme found in this context.');
    return theme!.data;
  }

  static KurumiBehaviorData behaviorOf(BuildContext context) {
    final theme = maybeOf(context);
    assert(theme != null, 'No KurumiTheme found in this context.');
    return theme!.behavior;
  }

  static KurumiTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<KurumiTheme>();

  static KurumiBehaviorData? maybeBehaviorOf(BuildContext context) =>
      maybeOf(context)?.behavior;

  @override
  bool updateShouldNotify(KurumiTheme oldWidget) =>
      data != oldWidget.data || behavior != oldWidget.behavior;

  @override
  Widget wrap(BuildContext context, Widget child) => KurumiTheme(
    data: data,
    behavior: behavior,
    child: child,
  );
}

extension KurumiBuildContext on BuildContext {
  KurumiThemeData get kurumi => KurumiTheme.of(this);
  KurumiBehaviorData get kurumiBehavior => KurumiTheme.behaviorOf(this);
  KurumiSemanticColors get kurumiColors => kurumi.semanticColors;
}
