// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:

class CommentPostButton extends StatelessWidget {
  const CommentPostButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return KurumiTooltip(
      message: context.t.comment.comments,
      child: IconButton(
        splashRadius: 16,
        onPressed: onPressed,
        icon: const Icon(
          Symbols.mode_comment,
        ),
      ),
    );
  }
}
