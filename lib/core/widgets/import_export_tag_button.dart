// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../foundation/clipboard.dart';
import '../../foundation/display.dart';
import 'import_tag_dialog.dart';

const _kHint =
    'Each rule goes on a separate line:\n\nlong_hair score:<0\nblonde_hair';

class ImportExportTagButton extends ConsumerWidget {
  const ImportExportTagButton({
    required this.tags,
    required this.onImport,
    super.key,
  });

  final List<String> tags;
  final void Function(String tagString) onImport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KurumiPopupMenuButton(
      items: [
        KurumiPopupMenuItem(
          title: Text(context.t.settings.backup_and_restore.import),
          icon: const Icon(Icons.file_upload),
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, _, _) => ImportTagsDialog(
                padding: kPreferredLayout.isMobile ? 0 : 8,
                hint: _kHint,
                onImport: (tagString, _) {
                  onImport(tagString);
                },
              ),
            );
          },
        ),
        if (tags.isNotEmpty)
          KurumiPopupMenuItem(
            title: Text(context.t.settings.backup_and_restore.export),
            icon: const Icon(Icons.file_download),
            onTap: () {
              AppClipboard.copyAndToast(
                context,
                tags.join('\n'),
                //TODO: should create a new key for this instead of using the same key as favorite_tags.export_notification
                message: context.t.favorite_tags.export_notification,
              );
            },
          ),
      ],
    );
  }
}
