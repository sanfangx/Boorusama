import 'package:flutter/material.dart';

class KurumiGrayedOut extends StatelessWidget {
  const KurumiGrayedOut({
    required this.child,
    super.key,
    this.grayedOut = true,
    this.stackOverlay = const [],
    this.opacity,
    this.onTap,
  });

  final Widget child;
  final bool grayedOut;
  final List<Widget> stackOverlay;
  final double? opacity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = grayedOut
        ? Stack(
            children: [
              Opacity(
                opacity: opacity ?? 0.3,
                child: IgnorePointer(
                  child: child,
                ),
              ),
              ...stackOverlay,
              if (onTap != null)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: onTap,
                  ),
                ),
            ],
          )
        : child;

    return !grayedOut || onTap == null
        ? content
        : Semantics(
            button: true,
            onTap: onTap,
            child: content,
          );
  }
}
