import 'package:flutter/material.dart';

class KurumiDragLine extends StatelessWidget {
  const KurumiDragLine({
    super.key,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      width: 48,
      height: 6,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
