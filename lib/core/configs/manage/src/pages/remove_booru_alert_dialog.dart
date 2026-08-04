// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:

class RemoveBooruConfigAlertDialog extends StatelessWidget {
  const RemoveBooruConfigAlertDialog({
    required this.onConfirm,
    required this.title,
    required this.description,
    super.key,
  });

  final void Function() onConfirm;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return KurumiDialog(
      color: Kurumi.themeOf(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Kurumi.themeOf(context).colorScheme.error,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  context.t.generic.action.delete,
                  style: TextStyle(
                    color: Kurumi.themeOf(context).colorScheme.onError,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  context.t.generic.action.cancel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Kurumi.themeOf(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
