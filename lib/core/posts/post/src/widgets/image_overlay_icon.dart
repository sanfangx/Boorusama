// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

class ImageOverlayIcon extends StatelessWidget {
  const ImageOverlayIcon({
    required this.icon,
    super.key,
    this.size,
  });

  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final colors = Kurumi.semanticColorsOf(context);

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: colors.overlayDim,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Icon(
        icon,
        color: colors.onOverlayDim,
        size: size ?? 18,
        weight: 700,
      ),
    );
  }
}
