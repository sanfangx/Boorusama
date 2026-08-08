// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../routes/route_utils.dart';

class AddCustomDetailsButton extends ConsumerWidget {
  const AddCustomDetailsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: KurumiDottedBorderButton(
        borderColor: Kurumi.themeOf(context).colorScheme.hintColor,
        onTap: () {
          goToDetailsLayoutManagerForFullWidgets(ref);
        },
        title: context.t.settings.appearance.customize,
      ),
    );
  }
}
