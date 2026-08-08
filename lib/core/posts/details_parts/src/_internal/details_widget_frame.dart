// Package imports:
import 'package:kurumi/material.dart';

class DetailsWidgetSeparator extends StatelessWidget {
  const DetailsWidgetSeparator({
    required this.child,
    super.key,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: padding,
          child: child,
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
      ],
    );
  }
}
