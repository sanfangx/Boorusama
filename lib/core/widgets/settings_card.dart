// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../themes/theme/types.dart';

enum SettingsCardSurface {
  standard,
  high,
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    required this.child,
    super.key,
    this.onTap,
    this.margin,
    this.padding,
    this.title,
    this.trailing,
    this.surface = SettingsCardSurface.standard,
  });

  final Widget child;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final Widget? trailing;
  final SettingsCardSurface surface;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = this.title;

    return Container(
      margin:
          margin ??
          const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            SettingsCardTitle(
              title: title,
              trailing: trailing,
            ),
          Material(
            color: switch (surface) {
              SettingsCardSurface.standard => colorScheme.surfaceContainer,
              SettingsCardSurface.high => colorScheme.surfaceContainerHigh,
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: onTap,
              child: Container(
                padding:
                    padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsCardTitle extends StatelessWidget {
  const SettingsCardTitle({
    required this.title,
    super.key,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.hintColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
