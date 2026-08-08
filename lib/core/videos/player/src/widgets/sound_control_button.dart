// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../providers/sound_provider.dart';

class SoundControlButton extends ConsumerWidget {
  const SoundControlButton({
    super.key,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundOn = ref.watch(globalSoundStateProvider);
    final notifier = ref.watch(globalSoundStateProvider.notifier);

    return KurumiCircularIconButton(
      constraints: const BoxConstraints(),
      padding: padding ?? EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onPressed: notifier.toggle,
      icon: Icon(
        soundOn ? Symbols.volume_up : Symbols.volume_off,
        fill: 1,
      ),
    );
  }
}
