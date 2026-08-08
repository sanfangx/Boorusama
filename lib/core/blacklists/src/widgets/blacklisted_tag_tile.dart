// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

class BlacklistedTagTile extends StatelessWidget {
  const BlacklistedTagTile({
    required this.tag,
    required this.onEditTap,
    required this.onRemoveTag,
    super.key,
  });

  final String tag;
  final VoidCallback onEditTap;
  final void Function(String tag) onRemoveTag;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tag),
      trailing: KurumiPopupMenuButton(
        items: [
          KurumiPopupMenuItem(
            title: Text(context.t.blacklisted_tags.remove),
            onTap: () => onRemoveTag.call(tag),
          ),
          KurumiPopupMenuItem(
            title: Text(context.t.blacklisted_tags.edit),
            onTap: () => onEditTap.call(),
          ),
        ],
      ),
    );
  }
}
