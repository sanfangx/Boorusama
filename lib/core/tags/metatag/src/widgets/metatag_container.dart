// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

class MetatagContainer extends StatelessWidget {
  const MetatagContainer({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Kurumi.themeOf(context).colorScheme;

    return TextContainer(
      text: tag,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
    );
  }
}
