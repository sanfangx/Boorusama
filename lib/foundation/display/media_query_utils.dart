// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

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
