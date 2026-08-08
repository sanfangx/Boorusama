// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../foundation/html.dart';
import '../themes/colors/providers.dart';

class DismissableInfoContainer extends ConsumerWidget {
  const DismissableInfoContainer({
    required this.content,
    super.key,
    this.forceShow = false,
    this.mainColor,
    this.actions = const [],
    this.padding,
    this.buttonsPadding,
    this.onLinkTap,
  });

  final String content;
  final bool forceShow;
  final Color? mainColor;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? buttonsPadding;
  final OnTap? onLinkTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref
        .watch(booruChipColorsProvider)
        .fromColor(mainColor ?? Colors.grey);
    final kurumiColors = colors == null
        ? null
        : KurumiChipColors(
            foregroundColor: colors.foregroundColor,
            backgroundColor: colors.backgroundColor,
            borderColor: colors.borderColor,
          );

    return KurumiDismissibleInfoContainer(
      forceShow: forceShow,
      colors: kurumiColors,
      padding: padding,
      buttonsPadding: buttonsPadding,
      actions: actions,
      content: AppHtml(
        style: {
          'body': Style(
            color: colors?.foregroundColor,
          ),
          'a': Style(
            color: colors?.foregroundColor,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration.underline,
            textDecorationColor: colors?.foregroundColor,
          ),
        },
        data: content,
        onLinkTap: onLinkTap,
      ),
    );
  }
}
