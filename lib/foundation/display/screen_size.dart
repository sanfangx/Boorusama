// Package imports:
import 'package:kurumi/kurumi.dart';

typedef Screen = KurumiScreen;
typedef ScreenSize = KurumiScreenSize;

extension ScreenSizeX on ScreenSize {
  bool get isLarge => this != ScreenSize.small;
}
