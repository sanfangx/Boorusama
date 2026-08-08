// Package imports:
import 'package:kurumi/kurumi.dart' show Kurumi;
import 'package:kurumi/material.dart';

// Project imports:
import '../../colors/src/colors.dart';

export 'package:kurumi/kurumi.dart'
    show KurumiBrightness, KurumiColorSchemeX, KurumiThemeBuildContext;

extension AppThemeBuildContext on BuildContext {
  BoorusamaColors get colors =>
      Kurumi.themeOf(this).extension<BoorusamaColors>()!;
}
