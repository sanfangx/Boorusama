// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../themes/configs/types.dart';
import '../types/enums.dart';
import 'theme_list_tile.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({
    required this.theme,
    required this.onThemeUpdated,
    super.key,
  });

  final ThemeConfigs? theme;
  final void Function(ThemeConfigs? theme) onThemeUpdated;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KurumiSwitchListTile(
              title: Text(context.t.booru.appearance.turn_on),
              subtitle: Text(
                context.t.booru.appearance.turn_on_description,
              ),
              value: theme?.enable ?? false,
              onChanged: (value) => onThemeUpdated(
                theme?.copyWith(enable: value),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            KurumiGrayedOut(
              grayedOut: theme?.enable != true,
              child: ThemeListTile(
                updateMethod: ThemeUpdateMethod.saveAndUpdateLater,
                colorSettings: theme?.colors,
                onThemeUpdated: (colors) {
                  onThemeUpdated(
                    ThemeConfigs(
                      colors: colors,
                      enable: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
