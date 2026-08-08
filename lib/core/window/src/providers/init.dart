// Dart imports:
import 'dart:async';

// Package imports:
import 'package:kurumi/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initialize() async {
  await windowManager.ensureInitialized();

  unawaited(
    windowManager.waitUntilReadyToShow(
      const WindowOptions(
        minimumSize: Size(350, 350),
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      ),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    ),
  );
}
