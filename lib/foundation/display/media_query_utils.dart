// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

class RemoveLeftPaddingOnLargeScreen extends StatelessWidget {
  const RemoveLeftPaddingOnLargeScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KurumiRemoveLeftPaddingOnLargeScreen(
      isLargeScreen: context.isLargeScreen,
      child: child,
    );
  }
}
