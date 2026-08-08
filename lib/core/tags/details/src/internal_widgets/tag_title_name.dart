// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

class TagTitleName extends StatelessWidget {
  const TagTitleName({
    required this.tagName,
    super.key,
  });

  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        tagName.replaceAll('_', ' '),
        textAlign: TextAlign.center,
        style: Kurumi.themeOf(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
