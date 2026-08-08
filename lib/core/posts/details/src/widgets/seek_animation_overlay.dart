// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../../../../videos/player/widgets.dart';
import 'post_details_controller.dart';

class SeekAnimationOverlay extends StatelessWidget {
  const SeekAnimationOverlay({
    required this.controller,
    super.key,
  });

  final PostDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return KurumiActionAnimationOverlay(
      duration: kSeekAnimationDuration,
      triggerNotifier: controller.seekDirection,
      iconBuilder: (direction, progress) {
        return Stack(
          children: [
            if (direction == SeekDirection.backward)
              _PositionedSeekIcon(
                isLeft: true,
                icon: Symbols.fast_rewind,
                progress: progress,
              ),
            if (direction == SeekDirection.forward)
              _PositionedSeekIcon(
                isLeft: false,
                icon: Symbols.fast_forward,
                progress: progress,
              ),
          ],
        );
      },
    );
  }
}

const _kPadding = 60.0;

class _PositionedSeekIcon extends StatelessWidget {
  const _PositionedSeekIcon({
    required this.isLeft,
    required this.icon,
    required this.progress,
  });

  final bool isLeft;
  final IconData icon;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? _kPadding : null,
      right: isLeft ? null : _kPadding,
      top: 0,
      bottom: 0,
      child: Center(
        child: VideoActionIcon(
          icon: icon,
          progress: progress,
        ),
      ),
    );
  }
}
