// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../foundation/applock/types.dart';
import '../../../tracking/providers.dart';
import '../providers/settings_notifier.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_page_scaffold.dart';

class PrivacyPage extends ConsumerWidget {
  const PrivacyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifer = ref.watch(settingsNotifierProvider.notifier);
    final tracker = ref.watch(trackerProvider);

    return SettingsPageScaffold(
      title: Text(context.t.settings.privacy.privacy),
      children: [
        tracker.maybeWhen(
          data: (_) => KurumiSwitchListTile(
            title: Text(context.t.settings.privacy.enable_incognito_keyboard),
            subtitle: Text(
              context.t.settings.privacy.enable_incognito_keyboard_notice,
            ),
            value: settings.enableIncognitoModeForKeyboard,
            onChanged: (value) {
              notifer.updateSettings(
                settings.copyWith(
                  enableIncognitoModeForKeyboard: value,
                ),
              );
            },
          ),
          orElse: () => const SizedBox.shrink(),
        ),
        KurumiSwitchListTile(
          title: Text(context.t.settings.privacy.enable_biometric_lock),
          subtitle: Text(
            context.t.settings.privacy.enable_biometric_lock_notice,
          ),
          value: settings.appLockType.isBiometric,
          onChanged: (value) {
            notifer.updateSettings(
              settings.copyWith(
                appLockType: value ? AppLockType.biometrics : AppLockType.none,
              ),
            );
          },
        ),
      ],
    );
  }
}
