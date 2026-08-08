// Package imports:
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CenterPlayButton extends StatelessWidget {
  const CenterPlayButton({
    required this.backgroundColor,
    required this.show,
    required this.isPlaying,
    required this.isFinished,
    super.key,
    this.iconColor,
    this.onPressed,
    this.semanticLabel,
  });

  final Color backgroundColor;
  final Color? iconColor;
  final bool show;
  final bool isPlaying;
  final bool isFinished;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: show && onPressed != null,
      hidden: !show,
      label: semanticLabel,
      onTap: show ? onPressed : null,
      child: ColoredBox(
        color: Colors.transparent,
        child: Center(
          child: UnconstrainedBox(
            child: AnimatedOpacity(
              opacity: show ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 32,
                  padding: const EdgeInsets.all(12),
                  icon: isFinished
                      ? Icon(Symbols.replay, color: iconColor)
                      : AnimatedPlayPause(
                          color: iconColor,
                          playing: isPlaying,
                        ),
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedPlayPause extends StatefulWidget {
  const AnimatedPlayPause({
    required this.playing,
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final bool playing;
  final Color? color;

  @override
  State<StatefulWidget> createState() => AnimatedPlayPauseState();
}

class AnimatedPlayPauseState extends State<AnimatedPlayPause>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    value: widget.playing ? 1 : 0,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void didUpdateWidget(AnimatedPlayPause oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.playing != oldWidget.playing) {
      if (widget.playing) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedIcon(
        color: widget.color,
        size: widget.size,
        icon: AnimatedIcons.play_pause,
        progress: animationController,
      ),
    );
  }
}
