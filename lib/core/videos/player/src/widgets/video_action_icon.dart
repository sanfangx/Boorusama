// Package imports:
import 'package:kurumi/material.dart';

class VideoActionIcon extends StatelessWidget {
  const VideoActionIcon({
    required this.icon,
    required this.progress,
    super.key,
  });

  final IconData icon;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final scale = 0.8 + (progress * 0.4);

    return Transform.scale(
      scale: scale,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6 * progress),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: progress),
          size: 32,
          fill: 1,
        ),
      ),
    );
  }
}
