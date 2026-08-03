import 'package:flutter/foundation.dart';

bool kurumiIsMobilePlatform() {
  if (kIsWeb) return false;

  return switch (defaultTargetPlatform) {
    TargetPlatform.android || TargetPlatform.iOS => true,
    _ => false,
  };
}

bool kurumiIsDesktopPlatform() {
  if (kIsWeb) return false;

  return switch (defaultTargetPlatform) {
    TargetPlatform.linux ||
    TargetPlatform.macOS ||
    TargetPlatform.windows => true,
    _ => false,
  };
}
