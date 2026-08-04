// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:

class FilenamePreview extends StatelessWidget {
  const FilenamePreview({
    required this.filename,
    super.key,
    this.padding,
  });

  final String filename;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.hashtag,
            size: 16,
            color: Kurumi.themeOf(context).colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              filename,
              style: Kurumi.themeOf(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Kurumi.themeOf(context).colorScheme.hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
