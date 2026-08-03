// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../colors/src/colors.dart';

export 'package:kurumi/kurumi.dart'
    show KurumiBrightness, KurumiColorSchemeX, KurumiThemeBuildContext;

extension AppThemeBuildContext on BuildContext {
  BoorusamaColors get colors => Theme.of(this).extension<BoorusamaColors>()!;
}
