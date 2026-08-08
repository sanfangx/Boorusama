// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

class TagChangedText extends StatelessWidget {
  const TagChangedText({
    required this.title,
    required this.added,
    required this.removed,
    super.key,
  });

  final String title;
  final Set<String> added;
  final Set<String> removed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Kurumi.themeOf(context).textTheme;
    final positiveStyle = textTheme.bodySmall?.copyWith(
      color: Colors.green,
      fontWeight: FontWeight.w800,
    );
    final negativeStyle = textTheme.bodySmall?.copyWith(
      color: Colors.red,
      fontWeight: FontWeight.w800,
    );

    return RichText(
      text: TextSpan(
        text: title,
        style: textTheme.titleLarge,
        children: [
          if (added.isNotEmpty && removed.isNotEmpty)
            TextSpan(
              text: '+${added.length}',
              style: positiveStyle,
              children: [
                TextSpan(
                  text: ' -${removed.length}',
                  style: negativeStyle,
                ),
              ],
            )
          else if (added.isNotEmpty)
            TextSpan(
              text: '+${added.length}',
              style: positiveStyle,
            )
          else if (removed.isNotEmpty)
            TextSpan(
              text: '-${removed.length}',
              style: negativeStyle,
            ),
        ],
      ),
    );
  }
}
