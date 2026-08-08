// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../providers/internal_providers.dart';

class InvalidBooruWarningContainer extends ConsumerWidget {
  const InvalidBooruWarningContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Kurumi.themeOf(context).colorScheme;

    return ref
        .watch(validateConfigProvider)
        .maybeWhen(
          orElse: () => const SizedBox(),
          data: (value) => value == false
              ? KurumiWarningContainer(
                  title: 'Empty results',
                  contentBuilder: (context) => Text(
                    'The app cannot find any posts with this engine. Please try with another one.',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                )
              : const SizedBox(),
          error: (error, st) => Stack(
            children: [
              KurumiWarningContainer(
                title: context.t.generic.errors.error,
                contentBuilder: (context) => Text(
                  context.t.booru.invalid_booru_warning,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
