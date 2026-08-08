// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../foundation/html.dart';
import '../../../configs/config/providers.dart';
import '../../../configs/create/routes.dart';
import '../providers/listing_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/viewer_providers.dart';

class SettingsInteractionBlocker extends StatelessWidget {
  const SettingsInteractionBlocker({
    required this.description,
    required this.block,
    required this.child,
    super.key,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool block;
  final Widget description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KurumiGrayedOut(
          grayedOut: block,
          child: child,
        ),
        if (block)
          Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  vertical: 8,
                ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.info,
                    color: Kurumi.themeOf(context).colorScheme.error,
                  ),
                ),
                Expanded(
                  child: description,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class ListingSettingsInteractionBlocker extends ConsumerWidget {
  const ListingSettingsInteractionBlocker({
    required this.child,
    super.key,
    this.padding,
    this.onNavigateAway,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onNavigateAway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCustomListing = ref.watch(hasCustomListingSettingsProvider);
    final colorScheme = Kurumi.themeOf(context).colorScheme;
    final config = ref.watchConfig;

    return SettingsInteractionBlocker(
      padding: padding,
      block: hasCustomListing,
      description: AppHtml(
        data: context.t.booru.listing.overridden_notice,
        style: AppHtml.hintStyle(colorScheme),
        onLinkTap: (url, _, _) {
          if (url == 'booru-profiles') {
            goToUpdateBooruConfigPage(
              ref,
              config: config,
              initialTab: 'listing',
            );

            onNavigateAway?.call();
          }
        },
      ),
      child: child,
    );
  }
}

class ViewerSettingsInteractionBlocker extends ConsumerWidget {
  const ViewerSettingsInteractionBlocker({
    required this.child,
    super.key,
    this.padding,
    this.onNavigateAway,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onNavigateAway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCustomViewer = ref.watch(hasCustomViewerSettingsProvider);
    final colorScheme = Kurumi.themeOf(context).colorScheme;
    final config = ref.watchConfig;

    return SettingsInteractionBlocker(
      padding: padding,
      block: hasCustomViewer,
      description: AppHtml(
        data: context.t.booru.viewer.overridden_notice,
        style: AppHtml.hintStyle(colorScheme),
        onLinkTap: (url, _, _) {
          if (url == 'booru-profiles') {
            goToUpdateBooruConfigPage(
              ref,
              config: config,
              initialTab: 'viewer',
            );

            onNavigateAway?.call();
          }
        },
      ),
      child: child,
    );
  }
}

class ThemeSettingsInteractionBlocker extends ConsumerWidget {
  const ThemeSettingsInteractionBlocker({
    required this.child,
    super.key,
    this.padding,
    this.onNavigateAway,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onNavigateAway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCustomTheme = ref.watch(hasCustomThemeSettingsProvider);
    final config = ref.watchConfig;

    return SettingsInteractionBlocker(
      padding: padding,
      block: hasCustomTheme,
      description: AppHtml(
        data: context.t.booru.appearance.overridden_notice,
        style: AppHtml.hintStyle(Kurumi.themeOf(context).colorScheme),
        onLinkTap: (url, _, _) {
          if (url == 'booru-profiles') {
            goToUpdateBooruConfigPage(
              ref,
              config: config,
              initialTab: 'appearance',
            );

            onNavigateAway?.call();
          }
        },
      ),
      child: child,
    );
  }
}
