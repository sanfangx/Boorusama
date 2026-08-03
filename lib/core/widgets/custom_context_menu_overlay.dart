// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../foundation/display.dart';

class CustomContextMenuOverlay extends StatelessWidget {
  const CustomContextMenuOverlay({
    required this.child,
    super.key,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KurumiCustomContextMenuOverlay(
      backgroundColor: backgroundColor,
      mobileLayout: kPreferredLayout.isMobile,
      child: child,
    );
  }
}
