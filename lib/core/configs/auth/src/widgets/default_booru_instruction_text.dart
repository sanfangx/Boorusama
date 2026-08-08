// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../../foundation/html.dart';

class DefaultBooruInstructionText extends StatelessWidget {
  const DefaultBooruInstructionText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Kurumi.themeOf(context).textTheme.titleSmall?.copyWith(
        color: Kurumi.themeOf(context).colorScheme.hintColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class DefaultBooruInstructionHtmlText extends StatelessWidget {
  const DefaultBooruInstructionHtmlText(
    this.text, {
    super.key,
    this.onApiLinkTap,
  });

  final String text;
  final void Function()? onApiLinkTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Kurumi.themeOf(context).colorScheme;

    return AppHtml(
      data: text,
      style: AppHtml.hintStyle(colorScheme),
      onLinkTap: onApiLinkTap != null
          ? (url, attributes, element) {
              if (url == 'api-credentials') {
                onApiLinkTap!();
              }
            }
          : null,
    );
  }
}
