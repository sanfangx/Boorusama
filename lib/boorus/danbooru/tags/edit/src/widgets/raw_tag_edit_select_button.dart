// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

class RawTagEditSelectButton extends StatelessWidget {
  const RawTagEditSelectButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        backgroundColor: Kurumi.themeOf(
          context,
        ).colorScheme.surfaceContainerHighest,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Kurumi.themeOf(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
