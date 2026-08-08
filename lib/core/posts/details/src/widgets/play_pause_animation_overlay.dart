// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../../../../videos/player/widgets.dart';
import 'post_details_controller.dart';

class PlayPauseAnimationOverlay extends StatelessWidget {
  const PlayPauseAnimationOverlay({
    required this.controller,
    super.key,
  });

  final PostDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return KurumiActionAnimationOverlay(
      duration: kPlayPauseAnimationDuration,
      triggerNotifier: controller.playPauseAction,
      showEnd: 0.1,
      hideStart: 0.8,
      iconBuilder: (action, progress) {
        return Center(
          child: VideoActionIcon(
            icon: switch (action) {
              PlayPauseAction.play => Symbols.play_arrow,
              PlayPauseAction.pause => Symbols.pause,
            },
            progress: progress,
          ),
        );
      },
    );
  }
}
