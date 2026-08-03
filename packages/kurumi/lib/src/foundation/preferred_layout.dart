import 'package:flutter/widgets.dart';

import 'platform.dart';
import 'screen.dart';

const _kurumiRawPreferredLayout = String.fromEnvironment('PREFERRED_LAYOUT');

enum KurumiPreferredLayout {
  platform,
  mobile,
  desktop,
}

final kurumiPreferredLayout = switch (_kurumiRawPreferredLayout) {
  'mobile' => KurumiPreferredLayout.mobile,
  'desktop' => KurumiPreferredLayout.desktop,
  _ => KurumiPreferredLayout.platform,
};

extension KurumiPreferredLayoutX on KurumiPreferredLayout {
  bool get isMobile =>
      this == KurumiPreferredLayout.mobile ||
      (this == KurumiPreferredLayout.platform && kurumiIsMobilePlatform());

  bool get isDesktop =>
      this == KurumiPreferredLayout.desktop ||
      (this == KurumiPreferredLayout.platform && !kurumiIsMobilePlatform());
}

extension KurumiDisplayX on BuildContext {
  KurumiScreen get screen => KurumiScreen.of(this);
  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLargeScreen =>
      kurumiPreferredLayout.isDesktop ||
      (kurumiPreferredLayout.isMobile && MediaQuery.widthOf(this) > 880);
}

extension KurumiOrientationX on Orientation {
  bool get isLandscape => this == Orientation.landscape;
  bool get isPortrait => this == Orientation.portrait;
}
